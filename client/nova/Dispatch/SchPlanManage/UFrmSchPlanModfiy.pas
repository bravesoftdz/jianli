unit UFrmSchPlanModfiy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaHComboBox, NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, Menus;

type
  TFrmSchPlanModfiy = class(TSimpleEditForm)
    lblroute: TLabel;
    lblschedule: TLabel;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    lbldepartdate: TLabel;
    dpstartdate: TDateTimePicker;
    dpenddate: TDateTimePicker;
    lbl2: TLabel;
    edtstarttime: TDateTimePicker;
    lbldeparttime: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    NHccbTicketEntrance: TNovaHComboBox;
    NHccbVehiclepark: TNovaHComboBox;
    jsonUpdateScheduleplan: TjsonClientDataSet;
    grp1: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    dsScheduleResult: TDataSource;
    jcdsSchedule: TjsonClientDataSet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure edtstarttimeChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    departtime, ticketentrance, buspark: String;
    routeid,schedulestatusid, departstationid, scheduleplanid: int64;
  end;

var
  FrmSchPlanModfiy: TFrmSchPlanModfiy;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmSchPlanModfiy.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sresult, scheduleids: String;
begin
  inherited;
  if NHccbTicketEntrance.ItemIndex < 0 then
  begin
    SysDialogs.Warning('ÇëÑ¡Ôñ¼ìÆ±¿Ú£¡');
    NHccbTicketEntrance.SetFocus;
    Exit;
  end;
  if NHccbVehiclepark.ItemIndex < 0 then
  begin
    SysDialogs.Warning('ÇëÑ¡Ôñ³µ¿â£¡');
    NHccbVehiclepark.SetFocus;
    Exit;
  end;
  scheduleids := '';
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        if FieldByName('checked').AsBoolean then
        begin
          scheduleids := scheduleids + FieldByName('id').AsString + ',';
        end;
        Next;
      end;
      EnableControls;
    end;
  end;
  if (scheduleids = '') or  ((departtime <> formatdatetime('hh:mm', edtstarttime.Time))) then
    scheduleids := inttostr(edtschedule.Id) + ',';
  with jsonUpdateScheduleplan do
  begin
    try
      Active := false;
      params.ParamByName('scheduleids').Value := scheduleids;
      params.ParamByName('fromdate').Value := formatdatetime('yyyy-mm-dd',
        dpstartdate.Date);
      params.ParamByName('enddate').Value := formatdatetime('yyyy-mm-dd',
        dpenddate.Date);
      params.ParamByName('schedulestatus.updateby').Value :=
        SysInfo.LoginUserInfo.UserID;
      params.ParamByName('schedulestatus.departstationid').Value :=
        departstationid;
      params.ParamByName('schedulestatus.scheduleid').Value := edtschedule.Id;
      params.ParamByName('schedulestatus.buspark').Value :=
        NHccbVehiclepark.Text;
      params.ParamByName('schedulestatus.ticketentrance').Value :=
        NHccbTicketEntrance.Text;
      params.ParamByName('schedulestatus.departtime').Value := formatdatetime('hh:mm', edtstarttime.Time);
      params.ParamByName('schedulestatus.id').Value := schedulestatusid;
      Execute;
      nResult := params.ParamByName('flag').Value;
      sresult := params.ParamByName('msg').Value;

      if nResult = 1 then
      begin
        SysDialogs.ShowMessage(sresult);
        ModalResult := mrOk;
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;

    except
      on E: Exception do
      begin
        SysLog.WriteErr('ÐÞ¸Ä³µ¿â¼ìÆ±¿ÚÊ§°Ü£º' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSchPlanModfiy.edtstarttimeChange(Sender: TObject);
begin
  inherited;
  if (departtime <> formatdatetime('hh:mm', edtstarttime.Time)) then
  begin
    nvdbgrdh2.Enabled := false;
  end
  else
  begin
    nvdbgrdh2.Enabled := true;
  end;
end;

procedure TFrmSchPlanModfiy.FormShow(Sender: TObject);
begin
  inherited;
  with NHccbTicketEntrance do
  begin
    Active := false;
    params.ParamValues['filter_EQL_o!station.id'] := departstationid;
    Active := true;
  end;

  with NHccbVehiclepark do
  begin
    Active := false;
    params.ParamValues['filter_EQL_o!station.id'] := departstationid;
    Active := true;
  end;
  NHccbVehiclepark.SetItemIndexByField('name', buspark);
  NHccbTicketEntrance.SetItemIndexByField('name', ticketentrance);

  with jcdsSchedule do
  begin
    Active := false;
    params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      dpstartdate.DateTime);
    params.ParamValues['routeid'] := routeid;
    params.ParamValues['departstationid'] := departstationid;
    Active := true;
  end;
end;

procedure TFrmSchPlanModfiy.N1Click(Sender: TObject);
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

procedure TFrmSchPlanModfiy.N2Click(Sender: TObject);
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

procedure TFrmSchPlanModfiy.N3Click(Sender: TObject);
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
