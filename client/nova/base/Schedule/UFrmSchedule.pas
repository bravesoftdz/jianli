unit UFrmSchedule;

{ ------------------------------------
  功能说明：班次管理
  创建日期：2011.01.28
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox, NovaCheckedComboBox,
  NvPrnDbgeh, NvDbgridEh;

type
  TFrmScheduel = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Chkisoriginator: TCheckBox;
    Chkislinework: TCheckBox;
    Chkissellreturnticket: TCheckBox;
    GroupBox2: TGroupBox;
    TreeVRoute: TTreeView;
    CobDISTRICTTYPE: TNovaComboBox;
    CobWORKWAYS: TNovaComboBox;
    NcbbScheduleType: TNovaComboBox;
    NHelpRoute: TNovaHelp;
    Splitter1: TSplitter;
    NovaCkbOrg: TNovaCheckedComboBox;
    ssss: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultWORKTYPE: TWideStringField;
    jcdsResultWORKWAYS: TWideStringField;
    jcdsResultDISTRICTTYPE: TWideStringField;
    jcdsResultTYPE: TWideStringField;
    jcdsResultSTARTTIME: TWideStringField;
    jcdsResultRUNTIME: TFloatField;
    jcdsResultISPROPRIETARY: TBooleanField;
    jcdsResultISOVERTIME: TBooleanField;
    jcdsResultISSELLRETURNTICKET: TBooleanField;
    jcdsResultISLINEWORK: TBooleanField;
    jcdsResultISORIGINATOR: TBooleanField;
    jcdsResultISSALEAFTERREPORT: TBooleanField;
    jcdsResultISCANMIXCHECK: TBooleanField;
    jcdsResultPLANSEATNUM: TIntegerField;
    jcdsResultVIASTATION: TWideStringField;
    jcdsResultPRINTINFO: TWideStringField;
    jcdsResultREMARKS: TWideStringField;
    jcdsResultISAUDITED: TBooleanField;
    jcdsResultISAUDITPASS: TBooleanField;
    jcdsResultISACTIVE: TBooleanField;
    jcdsResultusername: TWideStringField;
    jcsdWorkType: TjsonClientDataSet;
    jcdsResultWORKTYPENAME: TWideStringField;
    jcdsworkways: TjsonClientDataSet;
    jcdsResultWORKWAYSNAME: TWideStringField;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;
    jcdsResultDISTRICTTYPENAME: TWideStringField;
    jcdsResultTYPENAME: TWideStringField;
    NEdtScheduleHelpCode: TNovaEdit;
    NCbbWorkType: TNovaComboBox;
    ChkISPROPRIETARY: TCheckBox;
    jcdsDelSchedule: TjsonClientDataSet;
    jcdsTreeRoute: TjsonClientDataSet;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultvehcilepark: TWideStringField;
    jcdsScheduleStop: TjsonClientDataSet;
    dsScheduleStop: TDataSource;
    jcdsDelScheduleStop: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultORGID: TLargeintField;
    jcdsResultROUTEID: TLargeintField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultCREATEBY: TLargeintField;
    jcdsResultUPDATEBY: TLargeintField;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    ToolBar3: TToolBar;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    DBGridEh2: TNvDbgridEh;
    jcdsResultendtime: TWideStringField;
    jcdsResultspacinginterval: TIntegerField;
    jcdsResultentranceid: TLargeintField;
    jcdsResultparkid: TLargeintField;
    jcdsResultCREATETIME: TDateTimeField;
    jcdsResultUPDATETIME: TDateTimeField;
    jcdsResultsynccode: TWideStringField;
    chkPlusSchedule: TCheckBox;
    chkSchedule: TCheckBox;
    jcdsResultislongstop: TBooleanField;
    jcdsResultisfixseat: TBooleanField;
    jcdsResultisneedfinger: TBooleanField;
    jcdsResultdriverfingernum: TLargeintField;
    jcdsResultendstation: TWideStringField;
    jcdsResultstartstationprice: TFloatField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure ToolButton21Click(Sender: TObject);
    procedure ToolButton23Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure ToolButton51Click(Sender: TObject);
  private
    { Private declarations }
    procedure query(routename: String);
    // procedure LoadTree(Sender: TTreeView);
    procedure qryScheduleStop(scheduleid: integer);
  public
    { Public declarations }
  end;

var
  FrmScheduel: TFrmScheduel;

implementation

uses PubFn, Services, UFrmScheduleStop, UFrmScheduleLongStopInfo,
  UFrmScheduleLongStop, UDMPublic, UFrmScheduleSeatReserve, UFrmScheduleEdit,
  UFrmScheduleBatchEdt;
{$R *.dfm}

procedure TFrmScheduel.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  // 报停
  if (jcdsResult.FieldByName('islongstop').AsBoolean) then
  begin
    Background := clRed; // clYellow;
  end;
end;

procedure TFrmScheduel.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true, sysinfo.LoginUserInfo.OrgID);
  jcsdWorkType.Active := false;
  jcsdWorkType.Active := true;

  jcdsworkways.Active := false;
  jcdsworkways.Active := true;
  jcdsDISTRICTTYPE.Active := false;
  jcdsDISTRICTTYPE.Active := true;

  jcdstype.Active := false;
  jcdstype.Active := true;
  CobWORKWAYS.Active := false;
  CobWORKWAYS.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
  NcbbScheduleType.Active := false;
  NcbbScheduleType.Active := true;
  NCbbWorkType.Active := false;
  NCbbWorkType.Active := true;
end;

procedure TFrmScheduel.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
  begin
    jcdsScheduleStop.Close;
    exit;
  end;
  qryScheduleStop(jcdsResult.FieldByName('id').AsInteger);
end;

procedure TFrmScheduel.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilterClick(Sender);
  end;
end;

procedure TFrmScheduel.qryScheduleStop(scheduleid: integer);
begin
  with jcdsScheduleStop do
  begin
    Active := false;
    Params.ParamValues['schedule.id'] := scheduleid;
    Active := true;
  end;
end;

procedure TFrmScheduel.query(routename: String);
begin
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    if NHelpRoute.Id > 0 then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id // routename;
    else
      Params.ParamValues['filter_EQL_r!id'] := null;
    Params.ParamValues['filter_LIKES_s!code'] := trim
      (NEdtScheduleHelpCode.Text);
    if CobWORKWAYS.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!workways'] := inttostr
        (CobWORKWAYS.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!workways'] := '';
    if CobDISTRICTTYPE.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!districttype'] := inttostr
        (CobDISTRICTTYPE.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!districttype'] := '';
    if NCbbWorkType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!worktype'] := inttostr
        (NCbbWorkType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!worktype'] := '';
    if NcbbScheduleType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!type'] := inttostr
        (NcbbScheduleType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!type'] := '';
    if Chkislinework.Checked then
      Params.ParamValues['filter_EQB_s!islinework'] := true
    else
      Params.ParamValues['filter_EQB_s!islinework'] := null;
    if Chkisoriginator.Checked then
      Params.ParamValues['filter_EQB_s!isoriginator'] := true
    else
      Params.ParamValues['filter_EQB_s!isoriginator'] := null;
    if Chkissellreturnticket.Checked then
      Params.ParamValues['filter_EQB_s!issellreturnticket'] := true
    else
      Params.ParamValues['filter_EQB_s!issellreturnticket'] := null;
    if ChkISPROPRIETARY.Checked then
      Params.ParamValues['filter_EQB_s!isproprietary'] := true
    else
      Params.ParamValues['filter_EQB_s!isproprietary'] := null;

    if (chkPlusSchedule.Checked) and (not chkSchedule.Checked) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := true;
    end
    else if (not chkPlusSchedule.Checked) and (chkSchedule.Checked) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := false;
    end
    else
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := null;
    end;

    Active := true;
    if RecordCount <= 0 then
    begin
      jcdsScheduleStop.Close;
    end
    else
    begin
      qryScheduleStop(jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
  // showmessage(inttostr(jcdsResult.recordcount) );
end;

procedure TFrmScheduel.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('ISLINEWORK').AsBoolean) then
  begin
    SysDialogs.ShowMessage('流水班次不需要设置固定留位信息！');
    exit;
  end;

  FrmScheduleSeatReserve := TFrmScheduleSeatReserve.Create(self);
  with FrmScheduleSeatReserve do
  begin
    Caption := '班次固定留位信息';
    NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
    NovaHelpSchedule.Id := jcdsResult.FieldByName('id').AsLargeInt;
    NovaHelpSchedule.Text := jcdsResult.FieldByName('code').AsString;
    if SysMainForm.showFormModal(FrmScheduleSeatReserve) = mrok then
    begin
      // qryScheduleStop(jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmScheduel.tbtnDeleteClick(Sender: TObject);
var
  sResult, log: string;
  nResult: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if SysDialogs.Confirm('删除操作', '确认要删除班次信息吗？') then
    with jcdsDelSchedule do
    begin
      Active := false;
      log := '营运线路=' + jcdsResult.FieldByName('routename').AsString;
      log := log + ',班次号=' + jcdsResult.FieldByName('code').AsString;
      Params.ParamValues['schedule.id'] := jcdsResult.FieldByName('id')
        .AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        SysLog.WriteLog('删除班次信息', '删除', log);
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);

    end;
end;

procedure TFrmScheduel.tbtnEditClick(Sender: TObject);
var
  curid: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmSchdeuleEdit := TFrmSchdeuleEdit.Create(self);
  with FrmSchdeuleEdit do
  begin
    Caption := '修改班次信息';
    edittype := Tedittype.update;
    Id := jcdsResult.FieldByName('id').AsInteger;
    curid := Id;
    NovaCbbOrg.SetItemIndexByField('id',
      jcdsResult.FieldByName('orgid').AsLargeInt);
    NovaCbbOrg.Enabled := false;
    code := jcdsResult.FieldByName('code').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    NHelpRoute.Enabled := false;
    NHelpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
    routeid:=NHelpRoute.Id;
    NEdtHelpCode.Text := jcdsResult.FieldByName('code').AsString;
    NEdtHelpCode.Enabled := false;
    worktype := jcdsResult.FieldByName('worktypename').AsString;
    workways := jcdsResult.FieldByName('workwaysname').AsString;
    districttype := jcdsResult.FieldByName('districttypename').AsString;
    scheduletype := jcdsResult.FieldByName('typename').AsString;

    medtStartTime.Text := jcdsResult.FieldByName('StartTime').AsString;
    NEdtRuntime.Text := jcdsResult.FieldByName('Runtime').AsString;
    NEdtEndStation.Text := jcdsResult.FieldByName('endstation').AsString;
    NEdtStartstationprice.Text := jcdsResult.FieldByName('startstationprice').AsString;
    NEdtPLANSEATNUM.Text := jcdsResult.FieldByName('PLANSEATNUM').AsString;
    Chkislinework.Checked := jcdsResult.FieldByName('ISLINEWORK').AsBoolean;
    if jcdsResult.FieldByName('ISLINEWORK').AsBoolean then
    begin
      DpEndTime.Enabled := true;
      Chkislinework.Enabled := true;
      NovaEdtSpacinginterval.Enabled := true;
      DpEndTime.Time := jcdsResult.FieldByName('endtime').AsDateTime;
      NovaEdtSpacinginterval.Text := jcdsResult.FieldByName('spacinginterval')
        .AsString;
    end
    else
    begin
      DpEndTime.Enabled := false;
      NovaEdtSpacinginterval.Enabled := false;
    end;
    ChkISPROPRIETARY.Checked := jcdsResult.FieldByName('ISPROPRIETARY')
      .AsBoolean;
    Chkissellreturnticket.Checked := jcdsResult.FieldByName
      ('ISSELLRETURNTICKET').AsBoolean;
    ChkISCANMIXCHECK.Checked := jcdsResult.FieldByName('ISCANMIXCHECK')
      .AsBoolean;
    ChkISOVERTIME.Checked := jcdsResult.FieldByName('isovertime').AsBoolean;
    Cbxisneed.Checked := jcdsResult.FieldByName('isneedfinger').AsBoolean;
    NvedtDrivernum.Visible := jcdsResult.FieldByName('isneedfinger').AsBoolean;
    NvedtDrivernum.Text := jcdsResult.FieldByName('driverfingernum').AsString;
    ChkISSALEAFTERREPORT.Checked := jcdsResult.FieldByName('ISSALEAFTERREPORT')
      .AsBoolean;
    Chkisoriginator.Checked := jcdsResult.FieldByName('ISORIGINATOR').AsBoolean;
    Chkisfixseat.Checked := jcdsResult.FieldByName('isfixseat').AsBoolean;
    NEdtPRINTINFO.Text := jcdsResult.FieldByName('PRINTINFO').AsString;
    NEdtVIASTATION.Text := jcdsResult.FieldByName('VIASTATION').AsString;
    ChkPrintSeatno.Checked := jcdsResult.FieldByName('isaudited').AsBoolean;
    ChbPrintDepartTiime.Checked := jcdsResult.FieldByName('isauditpass').AsBoolean;
    MeREMARKS.Text := jcdsResult.FieldByName('REMARKS').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    NHccbTicketEntrance.SetItemIndexByField('id',
      jcdsResult.FieldByName('entranceid').AsLargeInt);
    NHccbVehiclepark.SetItemIndexByField('id',
      jcdsResult.FieldByName('parkid').AsLargeInt);
    CobWORKTYPE.ItemIndex := CobWORKTYPE.Items.IndexOf(worktype);
    CobWORKWAYS.ItemIndex := CobWORKWAYS.Items.IndexOf(workways);
    CobDISTRICTTYPE.ItemIndex := CobDISTRICTTYPE.Items.IndexOf(districttype);
    CobTYPE.ItemIndex := CobTYPE.Items.IndexOf(scheduletype);
    synccode := jcdsResult.FieldByName('synccode').AsString;
    if SysMainForm.showFormModal(FrmSchdeuleEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;
end;

procedure TFrmScheduel.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    NovaCkbOrg.SetFocus;
    exit;
  end;
  jcdsResult.AfterScroll := nil;
  query(trim(NHelpRoute.Text));
  jcdsResult.AfterScroll := jcdsResultAfterScroll;

end;

procedure TFrmScheduel.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  FrmSchdeuleEdit := TFrmSchdeuleEdit.Create(self);
  try
    with FrmSchdeuleEdit do
    begin
      Caption := '添加班次';
      createby := sysinfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(FrmSchdeuleEdit, false) = mrok then
      begin
        curid := Id;
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmSchdeuleEdit);
  end;
end;

procedure TFrmScheduel.tbtnSaveClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmScheduleLongStopInfo := TFrmScheduleLongStopInfo.Create(self);
  with FrmScheduleLongStopInfo do
  begin
    Caption := '班次长停信息';
    NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
    NovaHelpSchedule.Id := jcdsResult.FieldByName('id').AsLargeInt;
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    NovaHelpSchedule.Text := jcdsResult.FieldByName('code').AsString;
    ShowModal;
    tbtnFilterClick(Sender);
    jcdsResult.Locate('id', curid, []);
    { if SysMainForm.showFormModal(FrmScheduleLongStopInfo) = mrok then
      begin
      query(trim(NHelpRoute.Text));
      jcdsResult.Locate('id',curid,[]);
      end; }
  end;
end;

procedure TFrmScheduel.ToolButton21Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmScheduleStop := TFrmScheduleStop.Create(self);
  with FrmScheduleStop do
  begin
    Caption := '添加班次停靠点信息';
    createby := sysinfo.LoginUserInfo.UserID;
    routeid := jcdsResult.FieldByName('routeid').AsLargeInt;
    scheduleid := jcdsResult.FieldByName('id').AsLargeInt;
    scheduleorgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    isedit := false;
    dtStartTime.Enabled := false;
    NHccbTicketEntrance.Enabled := false;
    NHccbVehiclepark.Enabled := false;
    if SysMainForm.showFormModal(FrmScheduleStop) = mrok then
    begin
      qryScheduleStop(jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmScheduel.ToolButton23Click(Sender: TObject);
begin
  inherited;
  if not jcdsScheduleStop.Active then
    exit;
  if jcdsScheduleStop.RecordCount <= 0 then
    exit;
  FrmScheduleStop := TFrmScheduleStop.Create(self);
  with FrmScheduleStop do
  begin
    Caption := '修改班次停靠点信息';
    createby := sysinfo.LoginUserInfo.UserID;
    routeid := jcdsResult.FieldByName('routeid').AsInteger;
    scheduleorgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    scheduleid := jcdsResult.FieldByName('id').AsInteger;
    isedit := true;
    stationid := jcdsScheduleStop.FieldByName('stationid').AsLargeInt;
    orderno := jcdsScheduleStop.FieldByName('orderno').AsInteger;
    // vehicleparkid:=jcdsScheduleStop.FieldByName('vehicleparkid').AsInteger;
    Id := jcdsScheduleStop.FieldByName('id').AsInteger;
    isdepart := jcdsScheduleStop.FieldByName('isdepart').AsBoolean;
    chkIssellable.Checked := jcdsScheduleStop.FieldByName('issellable')
      .AsBoolean;
    if isdepart and (not jcdsScheduleStop.FieldByName('departtime').IsNull) then
      departtime := jcdsScheduleStop.FieldByName('departtime').AsDateTime;
    runtime := jcdsScheduleStop.FieldByName('runtime').AsString;
    ticketEntrance := jcdsScheduleStop.FieldByName('ticketEntrance').AsString;
    vehiclepark := jcdsScheduleStop.FieldByName('vehiclepark').AsString;
    createtime := jcdsScheduleStop.FieldByName('createtime').AsString;
    synccode := jcdsScheduleStop.FieldByName('synccode').AsString;
    createby := jcdsScheduleStop.FieldByName('createby').AsInteger;
    nvedtremark1.Text := jcdsScheduleStop.FieldByName('remark1').AsString;
    nvedtremark2.Text := jcdsScheduleStop.FieldByName('remark2').AsString;
    nvedtremark3.Text := jcdsScheduleStop.FieldByName('remark3').AsString;
    nvedtremark4.Text := jcdsScheduleStop.FieldByName('remark4').AsString;
    nvedtremark5.Text := jcdsScheduleStop.FieldByName('remark5').AsString;
    if SysMainForm.showFormModal(FrmScheduleStop) = mrok then
    begin
      qryScheduleStop(jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmScheduel.ToolButton26Click(Sender: TObject);
var
  sResult, log: string;
  nResult, scheduleid: integer;
begin
  inherited;
  if not jcdsScheduleStop.Active then
    exit;
  if jcdsScheduleStop.RecordCount <= 0 then
    exit;
  if jcdsScheduleStop.FieldByName('stationid').AsString = jcdsResult.FieldByName
    ('startstationid').AsString then
  begin
    SysDialogs.ShowError('不能删除始发站点！');
    exit;
  end;
  { if jcdsScheduleStop.FieldByName('stationid').AsString=jcdsResult.FieldByName('endstationid').AsString then
    begin
    SysDialogs.ShowError('不能删除终到站点！');
    exit;
    end; }
  scheduleid := jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作', '确认要删除该停靠点信息吗？') then
    with jcdsDelScheduleStop do
    begin
      Active := false;
      log := '营运线路=' + jcdsResult.FieldByName('routename').AsString;
      log := log + ',班次号=' + jcdsResult.FieldByName('code').AsString;
      Params.ParamValues['scheduleStop.id'] := jcdsScheduleStop.FieldByName
        ('id').AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin

        SysLog.WriteLog('删除班次停靠信息', '删除', log);
        qryScheduleStop(scheduleid);
      end;
    end;

end;

procedure TFrmScheduel.ToolButton50Click(Sender: TObject);
var
  curid: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmSchdeuleEdit := TFrmSchdeuleEdit.Create(self);
  with FrmSchdeuleEdit do
  begin
    Caption := '复制班次信息';
    edittype := Tedittype.add;
    Id := 0;
    NovaCbbOrg.SetItemIndexByField('id',
      jcdsResult.FieldByName('orgid').AsLargeInt);
    NovaCbbOrg.Enabled := false;
    code := jcdsResult.FieldByName('code').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    NHelpRoute.Enabled := false;
    NHelpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;

    worktype := jcdsResult.FieldByName('worktypename').AsString;
    workways := jcdsResult.FieldByName('workwaysname').AsString;
    districttype := jcdsResult.FieldByName('districttypename').AsString;
    scheduletype := jcdsResult.FieldByName('typename').AsString;

    medtStartTime.Text := jcdsResult.FieldByName('StartTime').AsString;
    NEdtRuntime.Text := jcdsResult.FieldByName('Runtime').AsString;
    NEdtPLANSEATNUM.Text := jcdsResult.FieldByName('PLANSEATNUM').AsString;
    Chkislinework.Checked := jcdsResult.FieldByName('ISLINEWORK').AsBoolean;
    ChkPrintSeatno.Checked := jcdsResult.FieldByName('isaudited').AsBoolean;
    if jcdsResult.FieldByName('ISLINEWORK').AsBoolean then
    begin
      DpEndTime.Enabled := true;
      NovaEdtSpacinginterval.Enabled := true;
      DpEndTime.Time := jcdsResult.FieldByName('endtime').AsDateTime;
      NovaEdtSpacinginterval.Text := jcdsResult.FieldByName('spacinginterval')
        .AsString;
    end
    else
    begin
      DpEndTime.Enabled := false;
      NovaEdtSpacinginterval.Enabled := false;
    end;
    ChkISPROPRIETARY.Checked := jcdsResult.FieldByName('ISPROPRIETARY')
      .AsBoolean;
    Chkissellreturnticket.Checked := jcdsResult.FieldByName
      ('ISSELLRETURNTICKET').AsBoolean;
    ChkISCANMIXCHECK.Checked := jcdsResult.FieldByName('ISCANMIXCHECK')
      .AsBoolean;
    ChkISOVERTIME.Checked := jcdsResult.FieldByName('isovertime').AsBoolean;
    ChkISSALEAFTERREPORT.Checked := jcdsResult.FieldByName('ISSALEAFTERREPORT')
      .AsBoolean;
    Chkisoriginator.Checked := jcdsResult.FieldByName('ISORIGINATOR').AsBoolean;
    NEdtPRINTINFO.Text := jcdsResult.FieldByName('PRINTINFO').AsString;
    NEdtVIASTATION.Text := jcdsResult.FieldByName('VIASTATION').AsString;
    MeREMARKS.Text := jcdsResult.FieldByName('REMARKS').AsString;
    createby := sysinfo.LoginUserInfo.UserID;
    NHccbTicketEntrance.SetItemIndexByField('id',
      jcdsResult.FieldByName('entranceid').AsLargeInt);
    NHccbVehiclepark.SetItemIndexByField('id',
      jcdsResult.FieldByName('parkid').AsLargeInt);
    CobWORKTYPE.ItemIndex := CobWORKTYPE.Items.IndexOf(worktype);
    CobWORKWAYS.ItemIndex := CobWORKWAYS.Items.IndexOf(workways);
    CobDISTRICTTYPE.ItemIndex := CobDISTRICTTYPE.Items.IndexOf(districttype);
    CobTYPE.ItemIndex := CobTYPE.Items.IndexOf(scheduletype);
    Chkisfixseat.Checked := jcdsResult.FieldByName('isfixseat').AsBoolean;
    Cbxisneed.Checked := jcdsResult.FieldByName('isneedfinger').AsBoolean;
    ChbPrintDepartTiime.Checked := jcdsResult.FieldByName('isauditpass').AsBoolean;
    // synccode :=jcdsResult.FieldByName('synccode').AsString;
    if SysMainForm.showFormModal(FrmSchdeuleEdit) = mrok then
    begin
      curid := Id;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;

end;

procedure TFrmScheduel.ToolButton51Click(Sender: TObject);
var
  curid: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmScheduleBatchEdt := TFrmScheduleBatchEdt.Create(self);
  with FrmScheduleBatchEdt do
  begin
    Caption := '修改班次信息';
    edittype := Tedittype.update;
    scheduleid := jcdsResult.FieldByName('id').AsInteger;
    curid := scheduleid;
    code := jcdsResult.FieldByName('code').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    NHelpRoute.Enabled := false;
    NHelpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;

    worktype := jcdsResult.FieldByName('worktypename').AsString;
    workways := jcdsResult.FieldByName('workwaysname').AsString;
    districttype := jcdsResult.FieldByName('districttypename').AsString;
    scheduletype := jcdsResult.FieldByName('typename').AsString;

    NEdtRuntime.Text := jcdsResult.FieldByName('Runtime').AsString;

    ChkISPROPRIETARY.Checked := jcdsResult.FieldByName('ISPROPRIETARY')
      .AsBoolean;
    Chkissellreturnticket.Checked := jcdsResult.FieldByName
      ('ISSELLRETURNTICKET').AsBoolean;
    ChkISCANMIXCHECK.Checked := jcdsResult.FieldByName('ISCANMIXCHECK')
      .AsBoolean;
    ChkISSALEAFTERREPORT.Checked := jcdsResult.FieldByName('ISSALEAFTERREPORT')
      .AsBoolean;
    Chkisoriginator.Checked := jcdsResult.FieldByName('ISORIGINATOR').AsBoolean;
    NEdtPRINTINFO.Text := jcdsResult.FieldByName('PRINTINFO').AsString;
    ChkPrintSeatno.Checked := jcdsResult.FieldByName('isaudited').AsBoolean;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    NHccbTicketEntrance.SetItemIndexByField('id',
      jcdsResult.FieldByName('entranceid').AsLargeInt);
    NHccbVehiclepark.SetItemIndexByField('id',
      jcdsResult.FieldByName('parkid').AsLargeInt);
    CobWORKTYPE.ItemIndex := CobWORKTYPE.Items.IndexOf(worktype);
    CobWORKWAYS.ItemIndex := CobWORKWAYS.Items.IndexOf(workways);
    CobDISTRICTTYPE.ItemIndex := CobDISTRICTTYPE.Items.IndexOf(districttype);
    CobTYPE.ItemIndex := CobTYPE.Items.IndexOf(scheduletype);
    synccode := jcdsResult.FieldByName('synccode').AsString;
    if SysMainForm.showFormModal(FrmScheduleBatchEdt) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;
end;

end.
