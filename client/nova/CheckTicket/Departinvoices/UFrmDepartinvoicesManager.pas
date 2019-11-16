unit UFrmDepartinvoicesManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaPrint, Generics.Collections, NovaHComboBox, NovaEdit,
  NovaHelp, UFrmDepartinvoicesManagerEdit, NovaComboBox, NovaCheckedComboBox;

type
  TFrmDepartinvoicesManager = class(TSimpleCRUDForm)
    jcdsResultCancel: TjsonClientDataSet;
    jcdsResultRecover: TjsonClientDataSet;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    Label1: TLabel;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    nvhlpcode: TNovaHelp;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtdepartinvoicesno: TNovaEdit;
    nvhlpschedule: TNovaHelp;
    cbbstatus: TNovaComboBox;
    jcdsdepartinvoices: TjsonClientDataSet;
    lblroute: TLabel;
    nvhlproute: TNovaHelp;
    cbborg: TNovaCheckedComboBox;
    chkscheduleTypeY: TCheckBox;
    chkscheduleTypeN: TCheckBox;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    chkiscomputeno: TCheckBox;
    chkcomputeno: TCheckBox;
    jcdssecurityisture: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure nvhlprouteIdChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
      isAuthority,isinday:Boolean; //�Ƿ�ɸ���ע��
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmDepartinvoicesManager: TFrmDepartinvoicesManager;

implementation

uses Services, PubFn, UFrmChanageDepartVehicle,UDMPublic;
{$R *.dfm}

procedure TFrmDepartinvoicesManager.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.datetime := now();
  dtpenddate.datetime := now();

  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmDepartinvoicesManager.FormShow(Sender: TObject);
begin
  inherited;
  cbbstatus.Active := false;
  cbbstatus.Active := true;
  if dbgrdhResult.AutoGridSave then
  begin
    dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
  end;
end;

procedure TFrmDepartinvoicesManager.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{7D5B1824-8BC3-4778-87AF-59A306085AC5}' then
  begin
    isAuthority:=aEnable;
  end ;
  //ע�����ս��㵥
  if GUIDToString(key)='{BB6C77F4-22F6-4F0D-B263-C3222F2241CC}' then
  begin
    isinday:=aEnable;
  end ;
  if GUIDToString(key)='{BBCEFA4E-B7E8-4191-843C-A24FA9B00A02}' then
  begin
    tbtnEdit.Visible:=aEnable;
  end ;


end;

procedure TFrmDepartinvoicesManager.nvhlprouteIdChange(Sender: TObject);
begin
  inherited;
  if nvhlproute.Id>0 then
  begin
    tbtnFilterClick(sender);
  end;
end;

procedure TFrmDepartinvoicesManager.tbtnDeleteClick(Sender: TObject);
var nResult : LongWord;
    sResult : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ý��㵥�Ѿ����㣬����Ҫ�ָ���');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '0' then
  begin
    SysDialogs.ShowMessage('�ü�¼������״̬������Ҫ�ָ���');
    Exit;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫ�ָ��ü�¼��!') then
    exit;
  with jcdsResultRecover do
  begin
    Close;
    Params.ParamValues['departinvoices.id'] := jcdsResult.FieldByName('id').AsString;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���㵥������Ϣ�ָ�ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesManager.tbtnEditClick(Sender: TObject);
var nResult : LongWord;
    sResult, invoicesid : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.Warning('�ý��㵥�Ѿ����㣬����ע����');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.Warning('�ü�¼�Ѿ���ע��״̬��');
    Exit;
  end;

  if (not isAuthority) and (SysInfo.LoginUserInfo.UserName<>jcdsResult.FieldByName('printname').Value) then
  begin
    SysDialogs.Warning('����ע�������˵Ľ��㵥��');
    Exit;
  end;
  if not isinday then
  begin
     if jcdsResult.FieldByName('departdate').AsDateTime<Trunc(Now()) then
     begin
       SysDialogs.Warning('��û��Ȩ��ע�����ս��㵥��');
       Exit;
     end;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫע���ü�¼��') then
    exit;
  with jcdsResultCancel do
  begin
    Close;
    invoicesid := jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['departinvoices.id'] := invoicesid;
    Params.ParamValues['departinvoices.scheduleplanid'] := jcdsResult.FieldByName('scheduleplanid').Value;
    Params.ParamValues['departinvoices.cancel.id'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['departinvoices.cancelstation.id'] := SysInfo.LoginUserInfo.StationID;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := 'ע�����㵥����������='+jcdsResult.FieldByName('departdate').AsString+
        ',��·=' + jcdsResult.FieldByName('routename').AsString+
        ',���='+jcdsResult.FieldByName('schedulename').AsString + ',����='+
        jcdsResult.FieldByName('departinvoicesno').AsString + ',��Ʊ��='+
        jcdsResult.FieldByName('ticketnum').AsString;
        SysLog.WriteLog('��Ʊ����->���㵥����','ע�����㵥',log);
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', invoicesid, []);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���㵥������Ϣע��ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesManager.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyy-mm-dd', dtpstartdate.Date) > FormatDateTime('yyyy-mm-dd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
    if ((Trim(nvhlproute.Text) = '') and (Trim(nvhlpschedule.Text) = '') and
      (Trim(nvhlpcode.Text) = '') and (Trim(NovaHelpUnit.Text)= '') and
      (Trim(edtdepartinvoicesno.Text) = '') )
  and (Trunc(dtpenddate.Date-dtpstartdate.Date) > 0) then
  begin
    SysDialogs.ShowMessage('��û��������·����Ρ�Ӫ�˵�λ��Ӫ�˳��������ŵ�����£�ֻ�ܲ�ѯһ������ݣ�');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime);
      if Trim(edtdepartinvoicesno.Text) = '' then
      begin
        Params.ParamValues['filter_LIKES_t!departinvoicesno'] := '';
      end else
      begin
        Params.ParamValues['filter_LIKES_t!departinvoicesno'] := edtdepartinvoicesno.Text;
      end;
      begin
        Params.ParamValues['filter_INS_t!printorgid'] := cbborg.GetSelectID;
      end;
      if (((nvhlproute.Text)<>'') and (nvhlproute.Id>0)) then
       Params.ParamValues['filter_EQL_sc!route.id'] := nvhlproute.Id
      else
       Params.ParamValues['filter_EQL_sc!route.id'] := '';
      if (NovaHelpUnit.Text<>'') and (NovaHelpUnit.Id>0) then
      begin
        Params.ParamValues['filter_EQL_unit!id'] := NovaHelpUnit.Id;
      end
      else
      begin
        Params.ParamValues['filter_EQL_unit!id'] := null;
      end;

      if Trim(nvhlpschedule.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!scheduleid'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!scheduleid'] := nvhlpschedule.Id;
      end;
      if Trim(nvhlpcode.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!vehicleid'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!vehicleid'] := nvhlpcode.Id;
      end;
      if Trim(cbbstatus.Text) = '' then
      begin
        Params.ParamValues['filter_EQS_t!status'] := '';
      end else
      begin
        Params.ParamValues['filter_EQS_t!status'] := TCommInfo(cbbstatus.Items.Objects[cbbstatus.ItemIndex]).Value;
      end;

      if (chkscheduleTypeY.Checked and (not chkscheduleTypeN.Checked)) then
        begin
          Params.ParamValues['filter_EQB_sp!isovertime'] := True;
        end
      else
      if ((not chkscheduleTypeY.Checked) and  chkscheduleTypeN.Checked)  then
        begin
          Params.ParamValues['filter_EQB_sp!isovertime'] := false;
        end
      else
        begin
          Params.ParamValues['filter_EQB_sp!isovertime'] := null;
        end;
      if (chkiscomputeno.Checked and (not chkcomputeno.Checked)) then
        begin
          Params.ParamValues['filter_EQB_t!iscomputeno'] := True;
        end
      else if ((not chkiscomputeno.Checked) and  chkcomputeno.Checked)  then
        begin
          Params.ParamValues['filter_EQB_t!iscomputeno'] := False;
        end
      else
      begin
        Params.ParamValues['filter_EQB_t!iscomputeno'] := null;
      end;
    Active := True;
  end;
end;

procedure TFrmDepartinvoicesManager.tbtnInsertClick(Sender: TObject);
var invoicesid, nResult : LongWord;
    sResult, temp ,msg1: string;
    curid:Int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ý��㵥�Ѿ����㣬���ܲ�����');
    Exit;
  end;
 { if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ý��㵥�Ѿ�ע�������ܲ�����');
    Exit;
  end; }

  {with jcdsdepartinvoices do
  begin
    Params.ParamValues['departinvoices.scheduleplanid'] := jcdsResult.FieldByName('scheduleplanid').AsString;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin

      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        Exit;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���㵥������Ϣע��ʧ�ܣ�' + E.Message);
      end;
    end;
  end; }
  with jcdssecurityisture do
  begin
     active:=false;
     Params.ParamValues['vehiclereportid']:=jcdsResult.FieldByName('reportid').AsString;
     Execute;
     msg1:=Params.ParamValues['msg1'];
  end;
  if  (msg1='securityisfalse')
     and ((getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0')) then
    begin
        SysDialogs.ShowMessage('�ó����첻�ϸ񣬲��ܲ�����');
        exit;
    end;

  with FrmDepartinvoicesManagerEdit do
  begin
    FrmDepartinvoicesManagerEdit := TFrmDepartinvoicesManagerEdit.Create(Self);
    Caption := '�������㵥';
    sign := true;
    //�������㵥��ʱ���Ƿ���д��ƱԱ 0:�� 1:��
    if (getParametervalue('3066', Sysinfo.LoginUserInfo.OrgID) = '0') then
    begin
      nvhlpseller.Visible := False;
      Label3.Visible := False;
    end else
    begin
      nvhlpseller.Visible := True;
      Label3.Visible := True;
    end;
    invoicesid := jcdsResult.FieldByName('id').AsInteger;
    departinvoicesid := jcdsResult.FieldByName('id').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('scheduleplanid').AsString;
    reportvehicleid := jcdsResult.FieldByName('reportid').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
    edtstarttime.Text:= jcdsResult.FieldByName('departtime').AsString;
    departtime:= jcdsResult.FieldByName('departtime').AsString;
    if jcdsResult.FieldByName('status').Value = '0' then
    begin
      isdepartinvoices := '0';
    end else
    begin
      isdepartinvoices := '';
    end;
    if SysMainForm.showFormModal(FrmDepartinvoicesManagerEdit, false) = mrok then
    begin
        curid:=newdepartinvoicesid;
        tbtnFilterClick(Self);
        jcdsResult.Locate('id', curid, []);
    end;
  end;
end;

procedure TFrmDepartinvoicesManager.ToolButton50Click(Sender: TObject);
var
  curid:Int64;
  msg1 : String ;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ý��㵥�Ѿ����㣬����������');
    Exit;
  end
  else if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ý��㵥�Ѿ�ע��������������');
    Exit;
  end;
   with jcdssecurityisture do
  begin
     active:=false;
     Params.ParamValues['vehiclereportid']:=jcdsResult.FieldByName('reportid').AsString;
     Execute;
     msg1:=Params.ParamValues['msg1'];
  end;
  if  (msg1='securityisfalse')
     and ((getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0')) then
     begin
          SysDialogs.ShowMessage('�ó����첻�ϸ񣬲��������ش�');
          exit;
     end;


  FrmChanageDepartVehicle := TFrmChanageDepartVehicle.Create(self);
  try
    with FrmChanageDepartVehicle do
    begin
      Caption := '�������´򵥲���';
      NovaEdtReportVehicle.Text:=jcdsResult.FieldByName('reportname').AsString;
      NovaEdtSeat.Text:=jcdsResult.FieldByName('seatnum').AsString;
      NovaEdtUnit.Text:=jcdsResult.FieldByName('unitname').AsString;
      schedulecode:= jcdsResult.FieldByName('schedulename').AsString;
      vehiclereportid:=jcdsResult.FieldByName('reportid').AsLargeInt;
      vehicleid:=jcdsResult.FieldByName('vehicleid').AsLargeInt;
      departdate:= jcdsResult.FieldByName('departdate').AsString;
      scheduleplanid:=jcdsResult.FieldByName('scheduleplanid').AsLargeInt;
      vehicleno:= jcdsResult.FieldByName('reportname').AsString;
      departtime:= jcdsResult.FieldByName('departtime').AsString;
      routename:= jcdsResult.FieldByName('routename').AsString;
      departstation:= jcdsResult.FieldByName('departstationname').AsString;
      endstation:= jcdsResult.FieldByName('endstationname').AsString;
      if SysMainForm.showFormModal(FrmChanageDepartVehicle, false) = mrok then
      begin
        curid:=departinvoicesid;
        tbtnFilterClick(Self);
        jcdsResult.Locate('id', curid, []);
        checkBillno('BalanceBill');
      end;
    end;
  finally
    FreeAndNil(FrmChanageDepartVehicle);
  end;
end;

end.
