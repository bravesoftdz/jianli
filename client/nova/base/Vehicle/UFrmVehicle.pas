unit UFrmVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls, NovaComboBox, NovaEdit, UDMPublic, NvPrnDbgeh, NvDbgridEh,
  NovaHComboBox, NovaHelp, Generics.Collections, NovaPrint, NovaCheckedComboBox;

type
  TFrmVehicle = class(TSimpleCRUDForm)
    lbl3: TLabel;
    jsonCDSDelVehicle: TjsonClientDataSet;
    lblunitid: TLabel;
    lblcardno: TLabel;
    lblvehicletypeid: TLabel;
    edt_vehicleno: TNovaEdit;
    edtcardno: TNovaEdit;
    NovaHVehicleTypes: TNovaHelp;
    jcdsResultid: TLargeintField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdsResultvehicletypeid: TLargeintField;
    jcdsResultvehiclebrandmodelid: TLargeintField;
    jcdsResultunitid: TLargeintField;
    jcdsResultrationseatnum: TIntegerField;
    jcdsResultseatnum: TIntegerField;
    jcdsResultloadamout: TFloatField;
    jcdsResultcolor: TWideStringField;
    jcdsResultcontactperson: TWideStringField;
    jcdsResultcontactphone: TWideStringField;
    jcdsResultremarks: TWideStringField;
    jcdsResultorgid: TLargeintField;
    jcdsResultcardno: TWideStringField;
    jcdsResultgrantdate: TDateField;
    jcdsResultcontractno: TWideStringField;
    jcdsResultcontractstartdate: TDateField;
    jcdsResultcontractenddate: TDateField;
    jcdsResultliabilityinsureno: TWideStringField;
    jcdsResultliabilityinsurestartdate: TDateField;
    jcdsResultliabilityinsureenddate: TDateField;
    jcdsResultcompulsoryinsureno: TWideStringField;
    jcdsResultcompulsoryinsurestartdate: TDateField;
    jcdsResultcompulsoryinsureenddate: TDateField;
    jcdsResultlicensestartdate: TDateField;
    jcdsResultlicenseenddate: TDateField;
    jcdsResultworkno: TWideStringField;
    jcdsResultworkstartdate: TDateField;
    jcdsResultworkenddate: TDateField;
    jcdsResultisaudited: TBooleanField;
    jcdsResultisauditpass: TBooleanField;
    jcdsResultgprs: TWideStringField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultcreatebyname: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultbrandname: TWideStringField;
    jcdsResultmodelcode: TWideStringField;
    jcdsResultvehicletypename: TWideStringField;
    jcdsQryVehicletype: TjsonClientDataSet;
    jscdQryVehicleColor: TjsonClientDataSet;
    jcdsResulttypename: TWideStringField;
    jcdsResultcolorname: TWideStringField;
    lbltype: TLabel;
    lblcontractno: TLabel;
    edtcontractno: TNovaEdit;
    NovaHelpUnits: TNovaHelp;
    jcdsResultsynccode: TWideStringField;
    jcdsResultvaliddate: TDateField;
    jcdsResultbalanceunitid: TLargeintField;
    jcdsResultmargin: TFloatField;
    jcdsResultstopfee: TFloatField;
    jcdsResultcheckfee: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResultvehiclenodate: TDateField;
    jcdsResultbalanceunitname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultrouteid: TLargeintField;
    Label1: TLabel;
    NovaHBalnaceUnit: TNovaHelp;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    jcdsResultentercardno: TWideStringField;
    jcdsResultmakedate: TDateField;
    jcdsResultcardnoprintdate: TDateField;
    jcdsResultistempvehicle: TBooleanField;
    jscdUpdatePrintDate: TjsonClientDataSet;
    jcdsResultfullname: TWideStringField;
    jcdsResultauditroute: TWideStringField;
    jcdsVehiclestatus: TjsonClientDataSet;
    wdstrngfldResultstatus: TWideStringField;
    wdstrngfldResultstatusname: TWideStringField;
    lbl1: TLabel;
    cbbstatus: TNovaComboBox;
    cbbChecktype: TNovaCheckedComboBox;
    wdstrngfldResultupdatebyname: TWideStringField;
    nvhlpvehiclecode: TNovaHelp;
    lbl2: TLabel;
    chkIstemp1: TCheckBox;
    chkIstemp2: TCheckBox;
    jcdsResultdriverlicense: TWideStringField;
    jcdsResultroadno: TWideStringField;
    jcdsResultmaintainvaliddate: TDateField;
    jcdsResultnextmaintaindistance: TLargeintField;
    jcdsResultisneedfinger: TBooleanField;
    jcdsVehicleSeattype: TjsonClientDataSet;
    jcdsResultseattype: TWideStringField;
    jcdsResultseattypename: TWideStringField;
    blnfldResultisneedcheck: TBooleanField;
    jcdsResulttwodimensionno: TWideStringField;
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure edt_vehiclenoKeyPress(Sender: TObject; var Key: Char);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    NovaPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    procedure printEnterCard(templatename: String);
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
    var AddVehicleInfo,AddOtherInfo:Boolean;
  end;

var
  FrmVehicle: TFrmVehicle;

implementation

uses PubFn, UFrmVehicleEdit;
{$R *.dfm}

procedure TFrmVehicle.edt_vehiclenoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key=#13) then
  begin
    tbtnFilterClick(sender);
  end;
end;

procedure TFrmVehicle.FormCreate(Sender: TObject);
begin
  inherited;
  jcdsQryVehicletype.Active := false;
  jcdsQryVehicletype.Active := True;
  jscdQryVehicleColor.Active := false;
  jscdQryVehicleColor.Active := True;
  jcdsVehicleSeattype.Active := false;
  jcdsVehicleSeattype.Active :=true;

  cbbstatus.Active := False;
  cbbstatus.Active := True;
  cbbChecktype.Active := False;
  cbbChecktype.Active := True;
 //// cbbChecktype.SetCheck(4,false);
//  cbbChecktype.SetCheck(5,false);
end;

procedure TFrmVehicle.HandleAuthority(const Key: TGUID; aEnable: boolean);
begin
  inherited;
  //
  if GUIDToString(Key) = '{2BFC6A45-CACA-4C0A-8BA5-861B6B393E2E}' then
  begin
    tbtnEdit.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{F1A6D504-7E1D-479B-B295-4821B3332786}' then
  begin
    tbtnDelete.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{56DA2C38-2C53-4FC4-9F9E-84F0E2919DBB}' then
  begin
    AddVehicleInfo := aEnable;
  end;
  if GUIDToString(Key) = '{92A56421-37C6-49B1-8479-542D5491ABA0}' then
  begin
    AddOtherInfo := aEnable;
  end;
end;

procedure TFrmVehicle.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key=#13) then
  begin
    tbtnFilterClick(sender);
  end;
end;

procedure TFrmVehicle.printEnterCard(templatename: String);
var
  curid: Int64;
begin
  try // '车辆进站卡发放表'
    with jscdUpdatePrintDate do
    begin
      curid := self.jcdsResult.FieldByName('id').AsLargeInt;
      Active := false;
      Params.ParamValues['vehicle.id'] := self.jcdsResult.FieldByName('id')
        .AsString;
      Execute;
      if not Assigned(printValue) then
        printValue := TDictionary<String, String>.Create
      else
        printValue.Clear;
      if not Assigned(NovaPrint) then
        NovaPrint := TNovaPrint.Create(self,
          TNovaPrint.GetTicketModelName(templatename, '车辆进站卡发放表'));
      printValue.add('vehicleno', jcdsResult.FieldByName('vehicleno').AsString);
      printValue.add('unitname', jcdsResult.FieldByName('unitname').AsString);
      printValue.add('fullname', jcdsResult.FieldByName('fullname').AsString);
      printValue.add('vehicletypename',
        jcdsResult.FieldByName('vehicletypename').AsString);
      printValue.add('seatnum', jcdsResult.FieldByName('seatnum').AsString);
      printValue.add('routename', jcdsResult.FieldByName('routename').AsString);
      printValue.add('workno', jcdsResult.FieldByName('workno').AsString);
      printValue.add('brandname', jcdsResult.FieldByName('brandname').AsString);
      printValue.add('entercardno',
        jcdsResult.FieldByName('entercardno').AsString);
      printValue.add('makedate', jcdsResult.FieldByName('makedate').AsString);
      printValue.add('orgname', Sysinfo.LoginUserInfo.OrgName);
      printValue.add('printer', Sysinfo.LoginUserInfo.UserName);
      printValue.Add('auditroute', jcdsResult.FieldByName('auditroute').AsString);
      printValue.Add('rationseatnum', jcdsResult.FieldByName('rationseatnum').AsString);

      NovaPrint.SingleValue := printValue;
      NovaPrint.Print;
      tbtnFilterClick(nil);
      jcdsResult.Locate('id',curid,[]);
    end;

  except
    on E: Exception do
    begin
      SysLog.WriteErr('打印车辆进站卡发放表操作失败：' + E.Message);
    end;
  end;
end;

procedure TFrmVehicle.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  if not(jcdsResult.Active) then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要打印车辆进站卡年审表吗？') then
    exit;
  printEnterCard('车辆进站卡年审表');
end;

procedure TFrmVehicle.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jsonCDSDelVehicle do
    try
      Params.ParamByName('vehicle.id').Value := jcdsResult.FieldByName('id')
        .AsInteger;
      Execute;
      flag := Params.ParamByName('flag').Value;
      msg := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(msg);
      if (flag = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车辆信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmVehicle.tbtnEditClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmVehicleEdit := TFrmVehicleEdit.Create(self);
  with FrmVehicleEdit do
  begin
    isupdates := True;
    Caption := '修改车辆信息';
    id := jcdsResult.FieldByName('id').AsLargeInt;
    curid := id;
    edtvehicleno.Enabled := false;
    edittype := view;
    orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    // 若为其他机构添加的，以下信息不能修改
    if (orgid <> Sysinfo.LoginUserInfo.orgid) then
    begin
     // NovaHelpUnit.Enabled := false;
      //cbbvehicletype.Enabled := false;
      //edtrationseatnum.Enabled := false;
      edtseatnum.Enabled := false;
    end;

    if jcdsResult.FieldByName('vehiclenodate').AsString <> '' then
    begin
      dtpvehiclenotime.Checked := false;
      dtpvehiclenotime.Date := jcdsResult.FieldByName('vehiclenodate')
        .AsDateTime;
    end;
    if jcdsResult.FieldByName('cardnoprintdate').AsString<>'' then
       printdate:=jcdsResult.FieldByName('cardnoprintdate').AsString;

    chkTempVehicle.Checked:=jcdsResult.FieldByName('istempvehicle').AsBoolean;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;

    edtvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    edtcardno.Text := jcdsResult.FieldByName('cardno').AsString;
    if jcdsResult.FieldByName('cardno').AsString <> '' then
    begin
      dtpCardValidate.Date := jcdsResult.FieldByName('validdate').AsDateTime;
      dtpCardValidate.Enabled := True;
    end;
    grantdate := jcdsResult.FieldByName('grantdate').AsString;
    edtrationseatnum.Text := jcdsResult.FieldByName('rationseatnum').AsString;
    edtseatnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    edtloadamout.Text := jcdsResult.FieldByName('loadamout').AsString;
    edtcontactperson.Text := jcdsResult.FieldByName('contactperson').AsString;
    edtcontactphone.Text := jcdsResult.FieldByName('contactphone').AsString;
    edtcontractno.Text := jcdsResult.FieldByName('contractno').AsString;
    NovaEdtAuditroute.Text := jcdsResult.FieldByName('auditroute').AsString;
    edttwono.Text :=  jcdsResult.FieldByName('twodimensionno').AsString;
    if jcdsResult.FieldByName('contractno').AsString <> '' then
    begin
      dtpcontractstartdate.Enabled := True;
      dtpcontractenddate.Enabled := True;
      dtpcontractstartdate.DateTime :=  jcdsResult.FieldByName('contractstartdate')
        .AsDateTime;
      dtpcontractenddate.DateTime := jcdsResult.FieldByName('contractenddate')
        .AsDateTime;
    end;
    NHelpRoute.id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    edtliabilityinsureno.Text := jcdsResult.FieldByName('liabilityinsureno')
      .AsString;
    if jcdsResult.FieldByName('liabilityinsureno').AsString <> '' then
    begin
      dtpliabilityinsurestartdate.Enabled := True;
      dtpliabilityinsureenddate.Enabled := True;
      dtpliabilityinsurestartdate.Date := jcdsResult.FieldByName
        ('liabilityinsurestartdate').AsDateTime;
      dtpliabilityinsureenddate.Date := jcdsResult.FieldByName
        ('liabilityinsureenddate').AsDateTime;
    end;
    synccode := jcdsResult.FieldByName('synccode').AsString;

    // 交强险

    edtcompulsoryinsureno.Text := jcdsResult.FieldByName('compulsoryinsureno')
      .AsString;
    if jcdsResult.FieldByName('compulsoryinsureno').AsString <> '' then
    begin
      dtpcompulsoryinsurestartdate.Enabled := True;
      dtpcompulsoryinsureenddate.Enabled := True;
      if not jcdsResult.FieldByName('compulsoryinsurestartdate').IsNull then
      begin
        dtpcompulsoryinsurestartdate.Date := jcdsResult.FieldByName
          ('compulsoryinsurestartdate').AsDateTime;
        dtpcompulsoryinsureenddate.Date := jcdsResult.FieldByName
          ('compulsoryinsureenddate').AsDateTime;
      end;
    end;
    // 营运证编号
    edtworkno.Text := jcdsResult.FieldByName('workno').AsString;
    if jcdsResult.FieldByName('workno').AsString <> '' then
    begin
      dtpworkenddate.Enabled := True;
      dtpworkenddate.Enabled := True;
      if not jcdsResult.FieldByName('workstartdate').IsNull then
      begin
        dtpworkstartdate.Date := jcdsResult.FieldByName('workstartdate')
          .AsDateTime;
        dtpworkenddate.Date := jcdsResult.FieldByName('workenddate').AsDateTime;
      end;
    end;
    if jcdsResult.FieldByName('driverlicense').AsString <> '' then
    begin
       NovaEdtdriverlicense.Text:=jcdsResult.FieldByName('driverlicense').AsString;
       dtplicensestartdate.Enabled:=true;
        dtplicenseenddate.Enabled:=true;
        if not jcdsResult.FieldByName('licensestartdate').IsNull then
        begin
          dtplicensestartdate.Date := jcdsResult.FieldByName('licensestartdate')
            .AsDateTime;
          dtplicenseenddate.Date := jcdsResult.FieldByName('licenseenddate')
            .AsDateTime;
        end;
    end;
    if jcdsResult.FieldByName('makedate').AsString <> '' then
    begin
      dtpMakeDate.Checked := True;
      dtpMakeDate.Date := jcdsResult.FieldByName('makedate').AsDateTime;
    end;
    if jcdsResult.FieldByName('maintainvaliddate').AsString <> '' then
    begin
      Dpmaintainvaliddate.Checked := true;
      Dpmaintainvaliddate.Date := jcdsResult.FieldByName('maintainvaliddate')
        .AsDateTime;
    end;
    NEdtNextmaintaindistance.Text :=jcdsResult.FieldByName('nextmaintaindistance').AsString;
    NovaEdtEnterNo.Text := jcdsResult.FieldByName('entercardno').AsString;
    NovaEdtroadno.Text := jcdsResult.FieldByName('roadno').AsString;
    mmoremarks.Text := jcdsResult.FieldByName('remarks').AsString;
    edtgprs.Text := jcdsResult.FieldByName('gprs').AsString;

    //cbbvehicletype.SetItemIndexByField('id',
    //  jcdsResult.FieldByName('vehicletypeid').AsInteger);
   // cbbvehicletypeChange(nil);
   nvhlpVehiclebrandmodel.id:=jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt;
   nvhlpVehiclebrandmodel.Text:=jcdsResult.FieldByName('brandname').AsString;
   // NvHcbbVehiclebrandmodel.SetItemIndexByField('id',
   //   jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt);
    NovaHelpUnit.id := jcdsResult.FieldByName('unitid').AsLargeInt;
    NovaHelpUnit.Text := jcdsResult.FieldByName('unitname').AsString;
    NovaHelpBalanceUnit.id := jcdsResult.FieldByName('balanceunitid')
      .AsLargeInt;
    NovaHelpBalanceUnit.Text := jcdsResult.FieldByName('balanceunitname')
      .AsString;

    cbbType.SetItemIndexByCode(jcdsResult.FieldByName('type').AsString);
    cbbstatus.SetItemIndexByCode(jcdsResult.FieldByName('status').AsString);
    cbbcolor.SetItemIndexByCode(jcdsResult.FieldByName('color').AsString);
    NovaEdtmargin.Text := jcdsResult.FieldByName('margin').AsString;
    NovaEdtstopfee.Text := jcdsResult.FieldByName('stopfee').AsString;
    NovaEdtcheckfee.Text := jcdsResult.FieldByName('checkfee').AsString;
    NovaEdtotherfee.Text := jcdsResult.FieldByName('otherfee').AsString;
    Cbxisneed.Checked :=  jcdsResult.FieldByName('isneedfinger').AsBoolean;
    vehicleseattype.SetItemIndexByCode(jcdsResult.FieldByName('seattype').AsString);
    chkisneedcheck.Checked:=jcdsResult.FieldByName('isneedcheck').AsBoolean; //是否需要证件核查才允许报班

    isaudited := jcdsResult.FieldByName('isaudited').AsBoolean;
    isauditpass := jcdsResult.FieldByName('isauditpass').AsBoolean;
    edtvehicleno.Enabled := false;
    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
      dbgrdhResult.SelectedRows.CurrentRowSelected := True;
    end;
  end;
end;

procedure TFrmVehicle.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if (chkIstemp1.Checked) and (not chkIstemp2.Checked) then
      Params.ParamValues['filter_EQB_v!istempvehicle'] := True
    else if (not chkIstemp1.Checked) and (chkIstemp2.Checked) then
      Params.ParamValues['filter_EQB_v!istempvehicle'] := false
    else
      Params.ParamValues['filter_EQB_v!istempvehicle'] := null;

    Params.ParamValues['filter_LIKES_v!vehicleno'] := edt_vehicleno.Text;
    Params.ParamByName('filter_LIKES_v!cardno').Value := edtcardno.Text;
    if (trim(NovaHelpUnits.Text) <> '') and (NovaHelpUnits.id > 0) then
      Params.ParamByName('filter_EQL_v!unitid').Value := NovaHelpUnits.id
    else
      Params.ParamByName('filter_EQL_v!unitid').Value := null;
    if (trim(NovaHBalnaceUnit.Text) <> '') and (NovaHBalnaceUnit.id > 0) then
      Params.ParamByName('filter_EQL_v!balanceunitid').Value :=
        NovaHBalnaceUnit.id
    else
      Params.ParamByName('filter_EQL_v!balanceunitid').Value := null;
    if (trim(NovaHVehicleTypes.Text) <> '') and (NovaHVehicleTypes.id > 0) then
      Params.ParamByName('filter_EQL_v!vehicletypeid').Value :=
        NovaHVehicleTypes.id
    else
      Params.ParamByName('filter_EQL_v!vehicletypeid').Value := null;
    if (trim(NHelpRoute.Text) <> '') and (NHelpRoute.id > 0) then
      Params.ParamByName('filter_EQL_v!routeid').Value := NHelpRoute.id
    else
      Params.ParamByName('filter_EQL_v!routeid').Value := null;
    if Trim(cbbstatus.Text) = '' then
      params.ParamByName('filter_EQS_v!status').Value := null
    else
      params.ParamByName('filter_EQS_v!status').Value := cbbstatus.GetSelectCode;
    if Trim(cbbChecktype.Text) = '' then
      Params.ParamByName('filter_INS_v!type').Value := null
    else
      Params.ParamByName('filter_INS_v!type').Value := cbbChecktype.GetSelectID;
    if Trim(nvhlpvehiclecode.Text) = '' then
      Params.ParamValues['filter_LIKELS_v!vehicleno'] := ''
    else
      Params.ParamValues['filter_LIKELS_v!vehicleno'] := nvhlpvehiclecode.Text;
    Active := True;
  end
end;

procedure TFrmVehicle.tbtnInsertClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;
  try
    FrmVehicleEdit := TFrmVehicleEdit.Create(self);
    with FrmVehicleEdit do
    begin
      isupdates := False;
      Caption := '添加车辆信息';
      grantdate := formatdatetime('yyyy-mm-dd', now);
      edittype := add;
      if SysMainForm.showFormModal(FrmVehicleEdit, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
        dbgrdhResult.SelectedRows.CurrentRowSelected := True;
      end;
    end;
  finally
    FreeAndNil(FrmVehicleEdit);
  end;
end;

procedure TFrmVehicle.tbtnSaveClick(Sender: TObject);
begin
  if not(jcdsResult.Active) then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要打印车辆进站卡发放表吗？') then
    exit;
  printEnterCard('车辆进站卡发放表');
end;

procedure TFrmVehicle.ToolButton51Click(Sender: TObject);
var
  curid: Int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmVehicleEdit := TFrmVehicleEdit.Create(self);
  with FrmVehicleEdit do
  begin
    isupdates := False;
    Caption := '添加车辆信息';
    edtvehicleno.Text := Copy(jcdsResult.FieldByName('vehicleno').AsString, 1,
      1);
    orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    edtrationseatnum.Text := jcdsResult.FieldByName('rationseatnum').AsString;
    edtseatnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    edtloadamout.Text := jcdsResult.FieldByName('loadamout').AsString;
    edtcontactperson.Text := jcdsResult.FieldByName('contactperson').AsString;
    edtcontactphone.Text := jcdsResult.FieldByName('contactphone').AsString;
    edtcontractno.Text := jcdsResult.FieldByName('contractno').AsString;
    NHelpRoute.id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    mmoremarks.Text := jcdsResult.FieldByName('remarks').AsString;

    //cbbvehicletype.SetItemIndexByField('id',
     // jcdsResult.FieldByName('vehicletypeid').AsInteger);
   //cbbvehicletypeChange(nil);
   nvhlpVehiclebrandmodel.Text:=jcdsResult.FieldByName('brandname').AsString;
    nvhlpVehiclebrandmodel.id:=jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt;
    NovaHelpUnit.id := jcdsResult.FieldByName('unitid').AsLargeInt;
    NovaHelpUnit.Text := jcdsResult.FieldByName('unitname').AsString;
    NovaHelpBalanceUnit.id := jcdsResult.FieldByName('balanceunitid')
      .AsLargeInt;
    NovaHelpBalanceUnit.Text := jcdsResult.FieldByName('balanceunitname')
      .AsString;
    cbbType.SetItemIndexByCode(jcdsResult.FieldByName('type').AsString);
    cbbcolor.SetItemIndexByCode(jcdsResult.FieldByName('color').AsString);
    ShowModal;
    if ModalResult = mrok then
    begin
      curid := id;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
      dbgrdhResult.SelectedRows.CurrentRowSelected := True;
    end;
  end;
end;

end.
