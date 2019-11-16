unit UFrmSchPlanModfiy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaHComboBox, NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, Menus, NovaComboBox;

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
    Label7: TLabel;
    CobWORKWAYS: TNovaComboBox;
    Label1: TLabel;
    EdtRemark: TEdit;
    Label14: TLabel;
    Label22: TLabel;
    CobWORKTYPE: TNovaComboBox;
    chkWorkline: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure edtstarttimeChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

uses Services, PubFn, UDMPublic,UFrmModDepartTime;
{$R *.dfm}

procedure TFrmSchPlanModfiy.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sresult, scheduleids: String;
  ismodothertime:boolean;
begin
  inherited;
  if CobWORKWAYS.ItemIndex<0 then
  begin
    SysDialogs.Warning('请选择营运方式！');
    CobWORKWAYS.SetFocus;
    Exit;
  end;
  if CobWORKTYPE.ItemIndex<0 then
  begin
    SysDialogs.Warning('请选择营运类别！');
    CobWORKTYPE.SetFocus;
    Exit;
  end;

  if NHccbTicketEntrance.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择检票口！');
    NHccbTicketEntrance.SetFocus;
    Exit;
  end;
  if NHccbVehiclepark.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择车库！');
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
      params.ParamByName('workways').Value := CobWORKWAYS.ItemIndex;
      params.ParamByName('remark').Value := EdtRemark.text;
      params.ParamByName('isworkline').Value := chkWorkline.Checked;

      params.ParamByName('worktype').Value := CobWORKTYPE.ItemIndex;

      Execute;
      nResult := params.ParamByName('flag').Value;
      sresult := params.ParamByName('msg').Value;

      if nResult = 1 then
      begin
        SysDialogs.ShowMessage(sresult);
        FrmModDepartTime:=TFrmModDepartTime.Create(self);
        FrmModDepartTime.edtNvroute.Text:=self.edtroute.Text;
        FrmModDepartTime.fromdate:=formatdatetime('yyyy-mm-dd',dpstartdate.Date);
        FrmModDepartTime.enddate:=formatdatetime('yyyy-mm-dd',dpenddate.Date);
        ismodothertime:=FrmModDepartTime.qryDepartime(scheduleplanid,departstationid);
        if ismodothertime then
        begin
            FrmModDepartTime.ShowModal;
        end;
        ModalResult := mrOk;
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;

    except
      on E: Exception do
      begin
        SysLog.WriteErr('修改车库检票口失败：' + E.Message);
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
//    SysDialogs.Warning('修改发车时间仅对当前'+edtschedule.Text+'班次有效！');
  end
  else
  begin
    nvdbgrdh2.Enabled := true;
  end;
end;

procedure TFrmSchPlanModfiy.FormCreate(Sender: TObject);
begin
  inherited;
  CobWORKWAYS.Active:=false;
  CobWORKWAYS.Active:=true;
  CobWORKTYPE.Active:=false;
  CobWORKTYPE.Active:=true;
  //if scheduleplanid then

end;

procedure TFrmSchPlanModfiy.FormShow(Sender: TObject);
begin
  inherited;
  with NHccbTicketEntrance do
  begin
    Active := false;
    params.ParamValues['departstationid'] := departstationid;
    params.ParamValues['scheduleid'] := edtschedule.Id;
    Active := true;
  end;

  with NHccbVehiclepark do
  begin
    Active := false;
    params.ParamValues['departstationid'] := departstationid;
    params.ParamValues['scheduleid'] := edtschedule.Id;
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
    params.ParamValues['scheduleplanid'] := scheduleplanid;
    Active := true;
  end;
  if dpstartdate.Date>dpenddate.Date then
  begin
      dpenddate.Date:= dpstartdate.Date;
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
