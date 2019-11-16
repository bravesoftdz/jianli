unit UFrmTicketoutletssellscheduleedit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet, NovaListView,
  NovaHComboBox, ImgList;

type
  TFrmTicketoutletssellscheduleEdit = class(TSimpleEditForm)
    lblticket: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lbltype: TLabel;
    lblstartdate: TLabel;
    lblenddate: TLabel;
    jsonCDSTicketoutletSave: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    Label1: TLabel;
    lbl3: TLabel;
    cbbticket: TNovaHelp;
    cbbtype: TNovaComboBox;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhlprouteChange(Sender: TObject);
    procedure nvhlprouteExit(Sender: TObject);
    procedure cbbtypeChange(Sender: TObject);
    procedure nvhlpscheduleEnter(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    sign: Boolean;
    id, createby, updateby, ticketid: LongWord;
    createtime, updatetime: TDateTime;
  end;

var
  FrmTicketoutletssellscheduleEdit: TFrmTicketoutletssellscheduleEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTicketoutletssellscheduleEdit.bbtnSaveClick(Sender: TObject);
var nResult: LongWord;
    sResult: string;
begin
  inherited;
  with jsonCDSTicketoutletSave do
  begin
    Close;
    if cbbticket.Id=0 then
    begin
      SysDialogs.Warning('请输入售票点！');
      cbbticket.SetFocus;
      exit;
    end;
    if cbbtype.ItemIndex < 0 then
    begin
      SysDialogs.Warning('请选择类型！');
      cbbtype.SetFocus;
      exit;
    end;
    if cbbtype.ItemIndex = 0 then
    begin
      Params.ParamByName('ticketoutletssellschedule.typeid').Value :=0 ;
    end else if cbbtype.ItemIndex = 1 then
    begin
      if nvhlproute.Id = 0 then
      begin
        SysDialogs.ShowMessage('请输入线路');
        nvhlproute.SetFocus;
        Exit;
      end;
      Params.ParamByName('ticketoutletssellschedule.typeid').Value :=nvhlproute.HelpFieldValue['id'];
    end else if cbbtype.ItemIndex = 2 then
    begin
      if Trim(nvhlpschedule.Text) = '' then
      begin
        SysDialogs.ShowMessage('请输入班次');
        nvhlpschedule.SetFocus;
        Exit;
      end;
      Params.ParamByName('ticketoutletssellschedule.typeid').Value :=nvhlpschedule.HelpFieldValue['id'];
    end;
    if Trunc(dtpstartdate.Date) >Trunc(dtpenddate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      dtpenddate.SetFocus;
      exit;
    end;
    if cbbticket.Id > 0 then
    begin
      ticketid := cbbticket.HelpFieldValue['id'];
    end;

    Params.ParamByName('ticketoutletssellschedule.id').Value :=id ;
    Params.ParamByName('ticketoutletssellschedule.createby').Value :=createby ;
    Params.ParamByName('ticketoutletssellschedule.updateby').Value :=updateby ;
    Params.ParamByName('ticketoutletssellschedule.createtime').Value :=DateTimeToStr(createtime);
    Params.ParamByName('ticketoutletssellschedule.updatetime').Value :=DateTimeToStr(updatetime);

    Params.ParamByName('ticketoutletssellschedule.type').Value :=TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    Params.ParamByName('ticketoutletssellschedule.startdate').Value :=DateTimeToStr(dtpstartdate.DateTime);
    Params.ParamByName('ticketoutletssellschedule.enddate').Value :=DateTimeToStr(dtpenddate.DateTime);
    Params.ParamByName('ticketoutletssellschedule.ticketoutletsid').Value := ticketid;
    //Params.ParamByName('route.id').Value :=nvhlproute.Id ;
    //Params.ParamByName('schedule.id').Value :=nvhlpschedule.Id;
    //Params.ParamByName('routestop.id').Value :=nvhlpschedulestop.Id;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
         log := '[售票点]='+cbbticket.Text+',[类型]='+cbbtype.Text;
        if cbbtype.ItemIndex = 1 then
        begin
          log := log + ',[线路]='+nvhlproute.Text;
        end else if cbbtype.ItemIndex = 2 then
        begin
          log := log + ',[线路]='+nvhlproute.Text+',[班次]='+nvhlpschedule.Text;
        end;
        SysLog.WriteLog('业务管理->售票点可售班次控制','添加可售班次',log);
        ModalResult := mrok;
      end
      else
      begin
        cbbticket.SetFocus;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('售票点可售班次添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTicketoutletssellscheduleEdit.cbbtypeChange(Sender: TObject);
begin
  inherited;
  if cbbtype.ItemIndex = 0 then
  begin
    nvhlproute.Text:= '';
    nvhlproute.Enabled:= false;
    nvhlpschedule.Text:= '';
    nvhlpschedule.Enabled:= false;
  end else if cbbtype.ItemIndex = 1 then
  begin
    nvhlproute.Enabled:= True;
    nvhlpschedule.Text:= '';
    nvhlpschedule.Enabled:= false;
    lbl4.Visible := True;
  end else if cbbtype.ItemIndex = 2 then
  begin
    nvhlpschedule.Text:= '';
    nvhlpschedule.Enabled:= True;
    nvhlproute.Text:= '';
    nvhlproute.Enabled:= True;
    lbl4.Visible := True;
    lbl5.Visible := True;
  end;
end;

procedure TFrmTicketoutletssellscheduleEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime:= Now();
  dtpenddate.DateTime:= Now();

  cbbtype.Active:= False;
  cbbtype.Active:= true;

end;

procedure TFrmTicketoutletssellscheduleEdit.nvhlprouteChange(Sender: TObject);
begin
  inherited;
  nvhlpschedule.Text := '';
end;

procedure TFrmTicketoutletssellscheduleEdit.nvhlprouteExit(Sender: TObject);
begin
  inherited;
  with nvhlpschedule do
  begin
    Params.ParamByName('filter_EQL_t!route.id').Value := nvhlproute.Id;
  end;
  nvhlpschedule.Active:= false;
  nvhlpschedule.Active:= true;
end;

procedure TFrmTicketoutletssellscheduleEdit.nvhlpscheduleEnter(Sender: TObject);
begin
  inherited;
  if nvhlproute.Id = 0 then
  begin
    SysDialogs.ShowMessage('请先输入线路！');
    nvhlproute.SetFocus;
    exit;
  end;
end;

end.
