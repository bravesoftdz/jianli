unit UFrmStatiionPriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, ComCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet, Menus, Generics.Collections;

type
  TFrmStatiionPriceEdt = class(TSimpleEditForm)
    lblroute: TLabel;
    lblschedule: TLabel;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    GroupBox1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    grp1: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    jsonQryTicketprices: TjsonClientDataSet;
    DsTicketprices: TDataSource;
    jcdsseattype: TjsonClientDataSet;
    jsonQryTicketpricesid: TLargeintField;
    jsonQryTicketpricesscheduleplanid: TLargeintField;
    jsonQryTicketpricesscheduleid: TLargeintField;
    jsonQryTicketpricesdepartstationid: TLargeintField;
    jsonQryTicketpricesreachstationid: TLargeintField;
    jsonQryTicketpricesseattype: TWideStringField;
    jsonQryTicketpricesfullprice: TFloatField;
    jsonQryTicketpriceshalfprice: TFloatField;
    jsonQryTicketpricesstudentprice: TFloatField;
    jsonQryTicketpricesissellable: TBooleanField;
    jsonQryTicketpricestoplimitprice: TFloatField;
    jsonQryTicketpricesmoreprice: TFloatField;
    jsonQryTicketpricesdepartstationname: TWideStringField;
    jsonQryTicketpricesreachstationname: TWideStringField;
    jsonQryTicketpricestypename: TWideStringField;
    jcdsSchedule: TjsonClientDataSet;
    dsScheduleResult: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    ischecks: TDictionary<int64, boolean>;
    function ischange: boolean;
  public
    { Public declarations }
    scheduleplanid, routeid: int64;
  end;

var
  FrmStatiionPriceEdt: TFrmStatiionPriceEdt;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmStatiionPriceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult, scheduleids: string;
begin
  inherited;
  if (formatdatetime('yyyy-mm-dd',dtpstartdate.DateTime)>
    formatdatetime('yyyy-mm-dd',dtpenddate.DateTime)) then
  begin
      SysDialogs.ShowMessage('结束日期不能小于开始日期！');
      Exit;
  end;
  with jsonQryTicketprices do
  begin
    if (ChangeCount = 0) and (not ischange) then
    begin
      SysDialogs.ShowMessage('数据未做任何修改！');
      Exit;
    end;
    try
      DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('fullprice').Value > FieldByName('toplimitprice')
          .Value then
        begin
          SysDialogs.ShowMessage('全票价不能大于上限价！');
          Exit;
        end;
        if FieldByName('studentprice').Value > FieldByName('toplimitprice')
          .Value then
        begin
          SysDialogs.ShowMessage('学生票价不能大于上限价！');
          Exit;
        end;
        if FieldByName('halfprice').Value > FieldByName('toplimitprice')
          .Value then
        begin
          SysDialogs.ShowMessage('半票票价不能大于上限价！');
          Exit;
        end;
        Next;
      end;
    finally
      EnableControls;
    end;
    scheduleids := '';
    with jcdsSchedule do
    begin
      try
        DisableControls;
        First;
        while not eof do
        begin
          if (FieldByName('checked').AsBoolean) then
            scheduleids := scheduleids + FieldByName('id').AsString + ',';
          Next;
        end;
      finally
        EnableControls;
      end;
    end;
    if (scheduleids = '') then
      scheduleids := jsonQryTicketprices.FieldByName('scheduleid').AsString
    else
    begin
      scheduleids := copy(scheduleids, 1, length(scheduleids) - 1);
    end;
    try
      Params.ParamByName('fromdate').Value := formatdatetime('yyyy-mm-dd',
        dtpstartdate.DateTime);
      Params.ParamByName('enddate').Value := formatdatetime('yyyy-mm-dd',
        dtpenddate.DateTime);
      Params.ParamByName('scheduleids').Value := scheduleids;
      ApplyUpdates(-1);
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('计划票价调整失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmStatiionPriceEdt.FormShow(Sender: TObject);
begin
  inherited;
  jcdsseattype.Active := false;
  jcdsseattype.Active := true;
  ischecks := TDictionary<int64, boolean>.create();
  with jcdsSchedule do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!route.id'] := routeid;
    Active := true;
  end;
  with jsonQryTicketprices do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Active := true;
    if (recordcount > 0) then
    begin
      try
        DisableControls;
        First;
        while not eof do
        begin
          ischecks.Add(FieldByName('id').AsLargeInt,
            FieldByName('issellable').AsBoolean);
          Next;
        end;
      finally
        EnableControls;
      end;
    end;
  end;
end;

function TFrmStatiionPriceEdt.ischange: boolean;
begin
 result := false;
  with jsonQryTicketprices do
  begin
    if (Active) and (recordcount > 0) then
    begin
      try
        DisableControls;
        First;
        while not eof do
        begin
          if (FieldByName('issellable').AsBoolean <> ischecks.Items[FieldByName
              ('id').AsLargeInt]) then
          begin
            result := true;
            Exit;
          end;
          Next;
        end;
      finally
        EnableControls;
      end;
    end;
  end;
end;

procedure TFrmStatiionPriceEdt.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('checked').Value := true;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TFrmStatiionPriceEdt.N2Click(Sender: TObject);
begin
  inherited;
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('checked').Value := not FieldByName('checked').AsBoolean;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TFrmStatiionPriceEdt.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('checked').Value := false;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

end.
