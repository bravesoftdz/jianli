unit UFrmScheduleCycle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaComboBox, NovaEdit, Grids, NovaHelp,
  NovaCheckedComboBox;

type
  TFrmScheduleCycle = class(TSimpleCRUDForm)
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    jcdsqrySchedule: TjsonClientDataSet;
    jcdsqryVehicle: TjsonClientDataSet;
    jcdsQryDriver: TjsonClientDataSet;
    jcdsQrySteward: TjsonClientDataSet;
    NvDbgridEh2: TNvDbgridEh;
    NvDbgridEh3: TNvDbgridEh;
    NvDbgridEh4: TNvDbgridEh;
    NvDbgridEh5: TNvDbgridEh;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    NvDbgridRules: TNvDbgridEh;
    ToolBar3: TToolBar;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton23: TToolButton;
    ToolButton22: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolBar2: TToolBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    ToolBar4: TToolBar;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton18: TToolButton;
    ToolBar5: TToolBar;
    ToolButton19: TToolButton;
    ToolButton24: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton30: TToolButton;
    Label2: TLabel;
    DataSource1: TDataSource;
    DsCycleschemesschedule: TDataSource;
    dsVehicle: TDataSource;
    dsDriver: TDataSource;
    dsSteward: TDataSource;
    jcdsQryRules: TjsonClientDataSet;
    jcdsDelScheduleCyle: TjsonClientDataSet;
    jcdsQryRulestype: TWideStringField;
    jcdsTypes: TjsonClientDataSet;
    jcdsQryRulestypename: TWideStringField;
    NvDbgridEh6: TNvDbgridEh;
    dsRules: TDataSource;
    jcdsQryRulesrule: TWideStringField;
    jcdsDelSchedulecycle: TjsonClientDataSet;
    Splitter2: TSplitter;
    jcdsQryRulesid: TLargeintField;
    ToolButton29: TToolButton;
    ToolButton31: TToolButton;
    jcdsDelSchedule: TjsonClientDataSet;
    jcdsnextSchedule: TjsonClientDataSet;
    jcdsPriorSchedule: TjsonClientDataSet;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    jcdsDelVehicle: TjsonClientDataSet;
    jcdsNextVehicle: TjsonClientDataSet;
    jcdsPriorVehicle: TjsonClientDataSet;
    jcdsDelDriver: TjsonClientDataSet;
    ToolButton5: TToolButton;
    ToolButton11: TToolButton;
    jcdsPriorDriver: TjsonClientDataSet;
    jcdsNextDriver: TjsonClientDataSet;
    ToolButton17: TToolButton;
    ToolButton34: TToolButton;
    jcdsDelSteward: TjsonClientDataSet;
    jcdsPriorSteward: TjsonClientDataSet;
    jcdsNextSteward: TjsonClientDataSet;
    Label3: TLabel;
    NovaHelpSchedule: TNovaHelp;
    Label1: TLabel;
    DateTpDepartDate: TDateTimePicker;
    Label4: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    ChkIsOvertime: TCheckBox;
    lbl3: TLabel;
    lblvehicletypeid: TLabel;
    NovaHelpVehicleTypes: TNovaHelp;
    lbl1: TLabel;
    NovaHelpBrand: TNovaHelp;
    lblunitid: TLabel;
    NovaHelpUnits: TNovaHelp;
    NovaHelpVehicleno: TNovaHelp;
    NovaEdtName: TNovaHelp;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton24Click(Sender: TObject);
    procedure jcdsQryRulesAfterScroll(DataSet: TDataSet);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure ToolButton30Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure ToolButton29Click(Sender: TObject);
    procedure ToolButton31Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure ToolButton23Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton32Click(Sender: TObject);
    procedure ToolButton33Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton34Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaEdtNameKeyPress(Sender: TObject; var Key: Char);
  private
    log : String;
    { Private declarations }
    curjsonClientDataSet: TjsonClientDataSet;
    procedure qryRules(cycleschemeid: integer);
    procedure qryCycleSchedule(cycleschemeid: integer);
    procedure qryCycleVehicle(cycleschemeid: integer);
    procedure qryCycleDriver(cycleschemeid: integer);
    procedure qryCycleSteward(cycleschemeid: integer);
  public
    { Public declarations }
  end;

var
  FrmScheduleCycle: TFrmScheduleCycle;

implementation

uses PubFn, Services,  UFrmCycleVehicle, UDMPublic,
  ruleConvert, UFrmScheduleCyleType,
  UFrmCycleSchedule, UFrmCycleDriver, UFrmCycleWard, UFrmScheduleCycleEdt;
{$R *.dfm}

procedure TFrmScheduleCycle.FormCreate(Sender: TObject);
begin
  inherited;
  DateTpDepartDate.Date := now;

end;

procedure TFrmScheduleCycle.FormShow(Sender: TObject);
begin
  inherited;
  jcdsTypes.Active := false;
  jcdsTypes.Active := true;

  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
end;

procedure TFrmScheduleCycle.jcdsQryRulesAfterScroll(DataSet: TDataSet);
var
  rules, item, ruletype, rulename: String;
  i: integer;
begin
  inherited;
  rules := jcdsQryRules.FieldByName('rule').AsString;
  ruletype := jcdsQryRules.FieldByName('type').AsString;
  if curjsonClientDataSet = nil then
  begin
    curjsonClientDataSet := TjsonClientDataSet.Create(self);
    curjsonClientDataSet.RemoteServer := UDMPublic.DMPublic.jcon;
  end;
  if (ruletype = '0') then
  begin
    curjsonClientDataSet.Close;
    curjsonClientDataSet.FieldDefs.Clear;
    with curjsonClientDataSet.FieldDefs.AddFieldDef do
    begin
      Name := 'status';
      DataType := ftBoolean;
    end;
    curjsonClientDataSet.Data := null;
    curjsonClientDataSet.CreateDataSet;
    for i := 1 to length(rules) do
    begin
      curjsonClientDataSet.Append;
      if (rules[i] = '1') then
        curjsonClientDataSet.FieldByName('status').Value := true
      else
        curjsonClientDataSet.FieldByName('status').Value := false;
    end;
    dsRules.DataSet := curjsonClientDataSet;
  end
  else
  begin
    if (length(rules) > 0) then
    begin
      rules := rules + ',';
      curjsonClientDataSet.Close;
      curjsonClientDataSet.FieldDefs.Clear;
      with curjsonClientDataSet.FieldDefs.AddFieldDef do
      begin
        Name := 'status';
        DataType := ftWideString;
        Size := 20;
      end;
      curjsonClientDataSet.CreateDataSet;
      while (length(rules) > 0) do
      begin
        curjsonClientDataSet.Append;
        item := copy(rules, 1, pos(',', rules) - 1);
        if (ruletype = '1') then
          rulename := getWeekName(item)
        else if (ruletype = '2') then
          rulename := getoldMonthName(item)
        else if (ruletype = '3') then
          rulename := getnewMonthName(item)
        else
          rulename := '';
        curjsonClientDataSet.FieldByName('status').Value := rulename;
        rules := copy(rules, pos(',', rules) + 1, length(rules));
      end;
      dsRules.DataSet := curjsonClientDataSet;
    end;
  end;

end;

procedure TFrmScheduleCycle.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryRules(jcdsResult.FieldByName('id').AsInteger);
  qryCycleSchedule(jcdsResult.FieldByName('id').AsInteger);
  qryCycleVehicle(jcdsResult.FieldByName('id').AsInteger);
  qryCycleDriver(jcdsResult.FieldByName('id').AsInteger);
  qryCycleSteward(jcdsResult.FieldByName('id').AsInteger);
end;

procedure TFrmScheduleCycle.NovaEdtNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key=#13) and (NovaEdtName.Id>0) then
  begin
     tbtnFilterClick(sender);
  end;
end;

procedure TFrmScheduleCycle.qryCycleDriver(cycleschemeid: integer);
begin
  with jcdsQryDriver do
  begin
    Active := false;
    Params.ParamValues['cyclescheme.id'] := cycleschemeid;
    Active := true;
  end;
end;

procedure TFrmScheduleCycle.qryCycleSchedule(cycleschemeid: integer);
begin
  with jcdsqrySchedule do
  begin
    Active := false;
    Params.ParamValues['cyclescheme.id'] := cycleschemeid;
    Active := true;
  end;
end;

procedure TFrmScheduleCycle.qryCycleSteward(cycleschemeid: integer);
begin
  with jcdsQrySteward do
  begin
    Active := false;
    Params.ParamValues['cyclescheme.id'] := cycleschemeid;
    Active := true;
  end;
end;

procedure TFrmScheduleCycle.qryCycleVehicle(cycleschemeid: integer);
begin
  with jcdsqryVehicle do
  begin
    Active := false;
    Params.ParamValues['cyclescheme.id'] := cycleschemeid;
    Active := true;
  end;
end;

procedure TFrmScheduleCycle.qryRules(cycleschemeid: integer);
begin
  with jcdsQryRules do
  begin
    Active := false;
    Params.ParamValues['cyclescheme.id'] := cycleschemeid;
    Active := true;
    if RecordCount <= 0 then
    begin
      jcdsQryRules.Close;
      if curjsonClientDataSet <> nil then
        curjsonClientDataSet.Close;
    end;
  end;
end;

procedure TFrmScheduleCycle.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  if SysDialogs.Confirm('删除操作', '确认要删除该班次循环组信息吗？') then
    with jcdsDelScheduleCyle do
    begin
      Active := false;
      Params.ParamValues['cyclescheme.id'] := jcdsResult.FieldByName('id')
        .AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
        log := '删除班次循环：循环名称='+jcdsResult.FieldByName('name').AsString+
        ',开始日期='+jcdsResult.FieldByName('startdate').AsString+',结束日期='+
        jcdsResult.FieldByName('enddate').AsString;
        SysLog.WriteLog('业务管理——>班次循环','删除',log);
        tbtnFilterClick(Sender);
    end;

end;

procedure TFrmScheduleCycle.tbtnEditClick(Sender: TObject);
var
  curid: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  FrmScheduleCycleEdt := TFrmScheduleCycleEdt.Create(self);
  with FrmScheduleCycleEdt do
  begin
    Caption := '修改班次循环组信息';
    createby := SysInfo.LoginUserInfo.UserID;
    id := jcdsResult.FieldByName('id').AsInteger;
    curid := id;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.Id:=jcdsResult.FieldByName('routeid').AsLargeInt;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    NovaEdtVEHICLEPERIOD.Text := jcdsResult.FieldByName('vehicleperiod')
      .AsString;
    NovaEdtVEHICLESTEP.Text := jcdsResult.FieldByName('vehiclestep').AsString;
    NovaEdtDRIVERPERIOD.Text := jcdsResult.FieldByName('driverperiod').AsString;
    NovaEdtDRIVERSTEP.Text := jcdsResult.FieldByName('driverstep').AsString;
    NovaEdtDRIVERNUM.Text := jcdsResult.FieldByName('drivernum').AsString;
    NovaEdtSTEWARDPERIOD.Text := jcdsResult.FieldByName('stewardperiod')
      .AsString;
    NovaEdtSTEWARDSTEP.Text := jcdsResult.FieldByName('stewardstep').AsString;
    NovaEdtSTEWARDNUM.Text := jcdsResult.FieldByName('stewardnum').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmScheduleCycleEdt) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;

end;

procedure TFrmScheduleCycle.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount=0) then
  begin
     SysDialogs.ShowMessage('请选择机构！');
     NovaCkbOrg.SetFocus;
     exit;
  end;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_s!orgid'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_LIKES_s!name'] := trim(NovaEdtName.Text);
    if DateTpDepartDate.Checked then
      Params.ParamValues['filter_GED_s!enddate'] := formatdatetime
        ('yyyy-mm-dd', DateTpDepartDate.Date)
    else
      Params.ParamValues['filter_GED_s!enddate'] := null;
    if (NovaHelpSchedule.id > 0) then
      Params.ParamValues['filter_EQL_ss!id'] := NovaHelpSchedule.id
    else
      Params.ParamValues['filter_EQL_ss!id'] := null;
    if ChkIsOvertime.Checked then
      Params.ParamValues['filter_EQB_ss!isovertime'] := true
    else
      Params.ParamValues['filter_EQB_ss!isovertime'] := null;

    if (trim(NovaHelpVehicleno.Text) <> '') and (NovaHelpVehicleno.id > 0) then
      Params.ParamByName('filter_EQL_cv!vehicleid').Value := NovaHelpVehicleno.id
    else
      Params.ParamByName('filter_EQL_cv!vehicleid').Value := null;

    if (trim(NovaHelpUnits.Text) <> '') and (NovaHelpUnits.id > 0) then
      Params.ParamByName('filter_EQL_cv!unitid').Value := NovaHelpUnits.id
    else
      Params.ParamByName('filter_EQL_cv!unitid').Value := null;
    if (trim(NovaHelpVehicleTypes.Text) <> '') and
      (NovaHelpVehicleTypes.id > 0) then
      Params.ParamByName('filter_EQL_cv!vehicletypeid').Value :=
        NovaHelpVehicleTypes.id
    else
      Params.ParamByName('filter_EQL_cv!vehicletypeid').Value := null;
    if (trim(NovaHelpBrand.Text) <> '') and (NovaHelpBrand.id > 0) then
      Params.ParamByName('filter_EQL_cv!vehiclebrandmodelid').Value :=
        NovaHelpBrand.id
    else
      Params.ParamByName('filter_EQL_cv!vehiclebrandmodelid').Value := null;

    Active := true;
    if RecordCount > 0 then
    begin
      qryRules(jcdsResult.FieldByName('id').AsInteger);
      qryCycleSchedule(jcdsResult.FieldByName('id').AsInteger);
      qryCycleVehicle(jcdsResult.FieldByName('id').AsInteger);
      qryCycleDriver(jcdsResult.FieldByName('id').AsInteger);
      qryCycleSteward(jcdsResult.FieldByName('id').AsInteger);
    end
    else
    begin
      jcdsQryRules.Close;
      jcdsqrySchedule.Close;
      jcdsqryVehicle.Close;
      jcdsQryDriver.Close;
    end;
  end;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmScheduleCycle.tbtnInsertClick(Sender: TObject);
var
  curid:Int64;
begin
  inherited;
  FrmScheduleCycleEdt := TFrmScheduleCycleEdt.Create(self);
  with FrmScheduleCycleEdt do
  begin
    Caption := '添加循环组信息';
    createby := SysInfo.LoginUserInfo.UserID;
    orgid := SysInfo.LoginUserInfo.orgid;
    DateTpFromDate.Date := now;
    //DateTpEndDate.Date := now;
    edittype := add;
    if SysMainForm.showFormModal(FrmScheduleCycleEdt,false) = mrok then
    begin
      curid:=id;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton11Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsQryDriver.Active then
    exit;
  if jcdsQryDriver.RecordCount <= 0 then
    exit;
  // 下移 驾驶员
  if jcdsQryDriver.RecNo = jcdsQryDriver.RecordCount then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsNextDriver do
  begin
    Active := false;
    id := jcdsQryDriver.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemesdriver.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleDriver(pid);
      jcdsQryDriver.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton12Click(Sender: TObject);
var
  sResult: string;
  nResult, pid: integer;
begin
  inherited;
  // 删除驾驶员循环
  if not jcdsQryDriver.Active then
    exit;
  if jcdsQryDriver.RecordCount <= 0 then
    exit;
  pid := jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作', '确认要删除该循环的驾驶员信息吗？') then
    with jcdsDelDriver do
    begin
      Active := false;
      Params.ParamValues['cycleschemesdriver.id'] := jcdsQryDriver.FieldByName
        ('id').AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
        log := '删除循环驾驶员：姓名='+jcdsQryDriver.FieldByName('drivername').AsString+
        ',工号='+jcdsQryDriver.FieldByName('code').AsString;
        SysLog.WriteLog('业务管理——>班次循环','循环驾驶员',log);
        qryCycleDriver(pid);
    end;

end;

procedure TFrmScheduleCycle.ToolButton14Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmCycleWard := TFrmCycleWard.Create(self);
  with FrmCycleWard do
  begin
    Caption := '添加乘务员循环信息';
    createby := SysInfo.LoginUserInfo.UserID;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    DateTpEndDate.Enabled := false;
    edittype := add;
    if SysMainForm.showFormModal(FrmCycleWard) = mrok then
    begin
      qryCycleSteward(pid);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton15Click(Sender: TObject);
begin
  inherited;
  if not jcdsQrySteward.Active then
    exit;
  if jcdsQrySteward.RecordCount <= 0 then
    exit;
  FrmCycleWard := TFrmCycleWard.Create(self);
  with FrmCycleWard do
  begin
    Caption := '修改乘务员循环信息';
    createby := SysInfo.LoginUserInfo.UserID;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    id := jcdsQrySteward.FieldByName('id').AsInteger;
    orderno := jcdsQrySteward.FieldByName('orderno').AsInteger;
    NovaHelpSteward.Text := jcdsQrySteward.FieldByName('stewardname').AsString;
    stewardname := jcdsQrySteward.FieldByName('stewardname').AsString;
    NovaHelpSteward.id := jcdsQrySteward.FieldByName('stewardid').AsInteger;
    createtime := jcdsQrySteward.FieldByName('createtime').AsString;
    DateTpEndDate.Enabled := false;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmCycleWard) = mrok then
    begin
      qryCycleSteward(pid);
      jcdsQrySteward.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton17Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsQrySteward.Active then
    exit;
  if jcdsQrySteward.RecordCount <= 0 then
    exit;
  // 上移乘务员
  if jcdsQrySteward.RecNo = 1 then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsPriorSteward do
  begin
    Active := false;
    id := jcdsQrySteward.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemessteward.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleSteward(pid);
      jcdsQrySteward.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton18Click(Sender: TObject);
var
  sResult: string;
  nResult, pid: integer;
begin
  inherited;
  // 删除乘务员循环
  if not jcdsQrySteward.Active then
    exit;
  if jcdsQrySteward.RecordCount <= 0 then
    exit;
  pid := jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作', '确认要删除该循环的乘务员信息吗？') then
    with jcdsDelSteward do
    begin
      Active := false;
      Params.ParamValues['cycleschemessteward.id'] := jcdsQrySteward.FieldByName
        ('id').AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
        log := '删除循环驾驶员：姓名='+jcdsQrySteward.FieldByName('stewardname').AsString+
        ',工号='+jcdsQrySteward.FieldByName('code').AsString;
        SysLog.WriteLog('业务管理——>班次循环','循环驾驶员',log);
        qryCycleSteward(pid);
    end;

end;

procedure TFrmScheduleCycle.ToolButton21Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmCycleSchedule := TFrmCycleSchedule.Create(self);
  with FrmCycleSchedule do
  begin
    Caption := '添加循环的班次信息';
    createby := SysInfo.LoginUserInfo.UserID;
    types :=1;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    DateTpEndDate.Enabled := false;
    with NovaListSchedule do
    begin
      active := false;
      Params.ParamValues['filter_EQL_r!id'] := jcdsResult.FieldByName('routeid').AsLargeInt;
      Params.ParamValues['filter_EQB_t!isovertime'] := 'false';
      active := true;
    end;
    edittype := add;
    if SysMainForm.showFormModal(FrmCycleSchedule) = mrok then
    begin
      qryCycleSchedule(pid);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton23Click(Sender: TObject);
begin
  inherited;
  if not jcdsqrySchedule.Active then
    exit;
  if jcdsqrySchedule.RecordCount <= 0 then
    exit;
  FrmCycleSchedule := TFrmCycleSchedule.Create(self);
  with FrmCycleSchedule do
  begin
    Caption := '修改循环的班次信息';
    createby := SysInfo.LoginUserInfo.UserID;
    types :=0;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    with NovaListSchedule do
    begin
      active := false;
      Params.ParamValues['filter_EQL_r!id'] := jcdsResult.FieldByName('routeid').AsLargeInt;
      Params.ParamValues['filter_EQB_t!isovertime'] := 'false';
      active := true;
    end;
    NovaListSchedule.SetCheck(jcdsqrySchedule,'scheduleid');
    NovaListSchedule.GetCount;
    DateTpEndDate.Enabled := false;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmCycleSchedule) = mrok then
    begin
      qryCycleSchedule(pid);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton24Click(Sender: TObject);
var
 curid:Int64;
begin
  inherited;
  FrmScheduleCycleType := TFrmScheduleCycleType.Create(self);
  with FrmScheduleCycleType do
  begin
    Caption := '添加班次循环策略';
    createby := SysInfo.LoginUserInfo.UserID;
    orgid := SysInfo.LoginUserInfo.orgid;
    pid := jcdsResult.FieldByName('id').AsInteger;
    curid:=pid;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    DateTpEndDate.Enabled := false;
    edittype := add;
    if SysMainForm.showFormModal(FrmScheduleCycleType) = mrok then
    begin
      qryRules(jcdsResult.FieldByName('id').AsInteger);
      //tbtnFilterClick(Sender);
      //jcdsResult.Locate('id', curid, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton26Click(Sender: TObject);
var
  sResult: string;
  nResult, pid: integer;
begin
  inherited;
  if not jcdsqrySchedule.Active then
    exit;
  if jcdsqrySchedule.RecordCount <= 0 then
    exit;
  pid := jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作', '确认要删除该循环的班次信息吗？') then
    with jcdsDelSchedule do
    begin
      Active := false;
      Params.ParamValues['cycleschemesschedule.id'] :=
        jcdsqrySchedule.FieldByName('id').AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
        log := '删除循环班次：班次号='+jcdsqrySchedule.FieldByName('helpcode').AsString+
        ',发车时间='+jcdsqrySchedule.FieldByName('starttime').AsString;
        SysLog.WriteLog('业务管理——>班次循环','循环班次',log);
        qryCycleSchedule(pid);
    end;
end;

procedure TFrmScheduleCycle.ToolButton27Click(Sender: TObject);
var
  curid: integer;
begin
  inherited;
  FrmScheduleCycleType := TFrmScheduleCycleType.Create(self);
  with FrmScheduleCycleType do
  begin
    Caption := '修改班次循环策略';
    createby := SysInfo.LoginUserInfo.UserID;
    orgid := SysInfo.LoginUserInfo.orgid;
    pid := jcdsResult.FieldByName('id').AsInteger;
    curid := 0;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    DateTpEndDate.Enabled := false;
    NovaCbbType.Enabled := false;
    if (jcdsQryRules.Active) and (jcdsQryRules.RecordCount > 0) then
    begin
      NovaCbbType.ItemIndex := jcdsQryRules.FieldByName('type').AsInteger;
      id := jcdsQryRules.FieldByName('id').AsInteger;
      curid := jcdsQryRules.FieldByName('id').AsInteger;
      ruletype := jcdsQryRules.FieldByName('type').AsInteger;
      if ruletype = 1 then
        rules1 := jcdsQryRules.FieldByName('rule').AsString
      else if ruletype = 2 then
        rules2 := jcdsQryRules.FieldByName('rule').AsString
      else if ruletype = 3 then
        rules3 := jcdsQryRules.FieldByName('rule').AsString
      else
        rules := jcdsQryRules.FieldByName('rule').AsString;
    end;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmScheduleCycleType) = mrok then
    begin
      qryRules(jcdsResult.FieldByName('id').AsInteger);
      jcdsQryRules.Locate('id', curid, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton29Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsqrySchedule.Active then
    exit;
  if jcdsqrySchedule.RecordCount <= 0 then
    exit;
  // 上移
  if jcdsqrySchedule.RecNo = 1 then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsPriorSchedule do
  begin
    Active := false;
    id := jcdsqrySchedule.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemesschedule.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleSchedule(pid);
      jcdsqrySchedule.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton2Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmCycleVehicle := TFrmCycleVehicle.Create(self);
  with FrmCycleVehicle do
  begin
    Caption := '添加车辆循环信息';
    createby := SysInfo.LoginUserInfo.UserID;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    DateTpEndDate.Enabled := false;
    edittype := add;
    if SysMainForm.showFormModal(FrmCycleVehicle) = mrok then
    begin
      qryCycleVehicle(pid);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton30Click(Sender: TObject);
var
  sResult: string;
  nResult, pid: integer;
begin
  inherited;
  // 删除该班次循环规则
  if not jcdsQryRules.Active then
    exit;
  if jcdsQryRules.RecordCount <= 0 then
    exit;
  pid := jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作', '确认要删除该班次循环规则信息吗？') then
    with jcdsDelSchedulecycle do
    begin
      Active := false;
      Params.ParamValues['schedulecycle.id'] := jcdsQryRules.FieldByName('id')
        .AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
        qryRules(pid);
    end;

end;

procedure TFrmScheduleCycle.ToolButton31Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsqrySchedule.Active then
    exit;
  if jcdsqrySchedule.RecordCount <= 0 then
    exit;
  // 下移
  if jcdsqrySchedule.RecNo = jcdsqrySchedule.RecordCount then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsnextSchedule do
  begin
    Active := false;
    id := jcdsqrySchedule.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemesschedule.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleSchedule(pid);
      jcdsqrySchedule.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton32Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsqryVehicle.Active then
    exit;
  if jcdsqryVehicle.RecordCount <= 0 then
    exit;
  // 上移车辆
  if jcdsqryVehicle.RecNo = 1 then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsPriorVehicle do
  begin
    Active := false;
    id := jcdsqryVehicle.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemesvehicle.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleVehicle(pid);
      jcdsqryVehicle.Locate('id', id, []);
    end;
  end;

end;

procedure TFrmScheduleCycle.ToolButton33Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsqryVehicle.Active then
    exit;
  if jcdsqryVehicle.RecordCount <= 0 then
    exit;
  // 下移 车辆
  if jcdsqryVehicle.RecNo = jcdsqryVehicle.RecordCount then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsNextVehicle do
  begin
    Active := false;
    id := jcdsqryVehicle.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemesvehicle.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleVehicle(pid);
      jcdsqryVehicle.Locate('id', id, []);
    end;
  end;

end;

procedure TFrmScheduleCycle.ToolButton34Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsQrySteward.Active then
    exit;
  if jcdsQrySteward.RecordCount <= 0 then
    exit;
  // 下移 乘务员
  if jcdsQrySteward.RecNo = jcdsQrySteward.RecordCount then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsNextSteward do
  begin
    Active := false;
    id := jcdsQrySteward.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemessteward.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleSteward(pid);
      jcdsQrySteward.Locate('id', id, []);
    end;
  end;

end;

procedure TFrmScheduleCycle.ToolButton3Click(Sender: TObject);
begin
  inherited;
  if not jcdsqryVehicle.Active then
    exit;
  if jcdsqryVehicle.RecordCount <= 0 then
    exit;
  FrmCycleVehicle := TFrmCycleVehicle.Create(self);
  with FrmCycleVehicle do
  begin
    Caption := '修改车辆循环信息';
    createby := SysInfo.LoginUserInfo.UserID;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    id := jcdsqryVehicle.FieldByName('id').AsInteger;
    orderno := jcdsqryVehicle.FieldByName('orderno').AsInteger;

    NovaHelpUnit.Text := jcdsqryVehicle.FieldByName('unitname').AsString;
    vehicleunitname := jcdsqryVehicle.FieldByName('unitname').AsString;
    NovaHelpUnit.id := jcdsqryVehicle.FieldByName('unitid').AsInteger;
    createtime := jcdsqryVehicle.FieldByName('createtime').AsString;
     NovaHelpVehiclenoHelp.OnIdChange := nil;
    NovaHelpVehiclenoHelp.Text := jcdsqryVehicle.FieldByName('vehicleno')
      .AsString;
      vehicle := jcdsqryVehicle.FieldByName('vehicleno').AsString;
    NovaHelpVehiclenoHelp.id := jcdsqryVehicle.FieldByName('vehicleid')
      .AsInteger;
    if jcdsqryVehicle.FieldByName('vehicleid')
      .AsInteger>0 then
    begin
      NovaHelpUnit.Enabled:=false;
    end;

    //NovaVehicletypeChange(nil);
    //vehicletype :=  NovaVehicletype.Text;
//    NvHcbbVehiclebrandmodel.SetItemIndexByField('id',jcdsqryVehicle.FieldByName('brandid').AsLargeInt);
    nvhlpVehiclebrandmodel.Id:= jcdsqryVehicle.FieldByName('brandid').AsLargeInt;
    nvhlpVehiclebrandmodel.Text:= jcdsqryVehicle.FieldByName('brandname').AsString;
    NovaHelpVehiclenoHelp.OnIdChange := NovaHelpVehiclenoHelpIdChange;
    Vehiclebrandmodel:= nvhlpVehiclebrandmodel.Text;
    DateTpEndDate.Enabled := false;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmCycleVehicle) = mrok then
    begin
      qryCycleVehicle(pid);
      jcdsqryVehicle.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton5Click(Sender: TObject);
var
  sResult: string;
  nResult, pid, id: integer;
begin
  inherited;
  if not jcdsQryDriver.Active then
    exit;
  if jcdsQryDriver.RecordCount <= 0 then
    exit;
  // 上移驾驶员
  if jcdsQryDriver.RecNo = 1 then
  begin
    exit;
  end;
  pid := jcdsResult.FieldByName('id').AsInteger;
  with jcdsPriorDriver do
  begin
    Active := false;
    id := jcdsQryDriver.FieldByName('id').AsInteger;
    Params.ParamByName('cycleschemesdriver.id').Value := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if nResult = 1 then
    begin
      qryCycleDriver(pid);
      jcdsQryDriver.Locate('id', id, []);
    end;
  end;

end;

procedure TFrmScheduleCycle.ToolButton6Click(Sender: TObject);
var
  sResult: string;
  nResult, pid: integer;
begin
  inherited;
  // 删除车辆循环
  if not jcdsqryVehicle.Active then
    exit;
  if jcdsqryVehicle.RecordCount <= 0 then
    exit;
  pid := jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作', '确认要删除该循环的车辆信息吗？') then
    with jcdsDelVehicle do
    begin
      Active := false;
      Params.ParamValues['cycleschemesvehicle.id'] := jcdsqryVehicle.FieldByName
        ('id').AsInteger;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
        log := '删除循环的车辆：车型='+jcdsqryVehicle.FieldByName('vehicletypename').AsString+
        ',厂牌型号='+jcdsqryVehicle.FieldByName('brandname').AsString+',座位数='+
        jcdsqryVehicle.FieldByName('rationseatnum').AsString+',车牌号='+
        jcdsqryVehicle.FieldByName('vehicleno').AsString;
        SysLog.WriteLog('业务管理——>班次循环','循环车辆',log);
        qryCycleVehicle(pid);
    end;

end;

procedure TFrmScheduleCycle.ToolButton8Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmCycleDriver := TFrmCycleDriver.Create(self);
  with FrmCycleDriver do
  begin
    Caption := '添加驾驶员循环信息';
    createby := SysInfo.LoginUserInfo.UserID;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    DateTpEndDate.Enabled := false;
    edittype := add;
    if SysMainForm.showFormModal(FrmCycleDriver) = mrok then
    begin
      qryCycleDriver(pid);
    end;
  end;
end;

procedure TFrmScheduleCycle.ToolButton9Click(Sender: TObject);
begin
  if not jcdsQryDriver.Active then
    exit;
  if jcdsQryDriver.RecordCount <= 0 then
    exit;
  FrmCycleDriver := TFrmCycleDriver.Create(self);
  with FrmCycleDriver do
  begin
    Caption := '修改驾驶员循环信息';
    createby := SysInfo.LoginUserInfo.UserID;
    pid := jcdsResult.FieldByName('id').AsInteger;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.ReadOnly := true;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpFromDate.Enabled := false;
    DateTpEndDate.Date := jcdsResult.FieldByName('EndDate').AsDateTime;
    id := jcdsQryDriver.FieldByName('id').AsInteger;
    orderno := jcdsQryDriver.FieldByName('orderno').AsInteger;
    NovaHelpDriver.Text := jcdsQryDriver.FieldByName('drivername').AsString;
    drivername := jcdsQryDriver.FieldByName('drivername').AsString;
    NovaHelpDriver.id := jcdsQryDriver.FieldByName('driverid').AsInteger;
    createtime := jcdsQryDriver.FieldByName('createtime').AsString;
    DateTpEndDate.Enabled := false;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmCycleDriver) = mrok then
    begin
      qryCycleDriver(pid);
      jcdsQryDriver.Locate('id', id, []);
    end;
  end;

end;

end.
