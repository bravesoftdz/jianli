unit UFrmVehicleviolation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, UFrmVehicleviolationEdit,
  UFrmVehicleviolationProcess, Generics.Collections, NovaPrint, NovaEdit,
  NovaHelp, NovaComboBox;

type
  TFrmVehicleviolation = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbldate: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    jcdsDelVehicleviolation: TjsonClientDataSet;
    jcdsResultPrint: TjsonClientDataSet;
    jcdshandleret: TjsonClientDataSet;
    lbl4: TLabel;
    nvhlphandle: TNovaHelp;
    lbl3: TLabel;
    Label1: TLabel;
    edtnotenum: TNovaEdit;
    NHelpRoute: TNovaHelp;
    lbl5: TLabel;
    nvhelpvehicleno: TNovaHelp;
    chkhandle: TCheckBox;
    chkishandle: TCheckBox;
    jcdsstatus: TjsonClientDataSet;
    jcdsbalancetype: TjsonClientDataSet;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultnotenum: TWideStringField;
    wdstrngfldResultvehicleno: TWideStringField;
    n: TWideStringField;
    dtfldResultviolationdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultremark: TWideStringField;
    wdstrngfldResultbillorname: TWideStringField;
    wdstrngfldResulthandleret: TWideStringField;
    fltfldResultbreachfee: TFloatField;
    blnfldResultishandle: TBooleanField;
    wdstrngfldResulthandlorname: TWideStringField;
    wdstrngfldResultbalancetype: TWideStringField;
    wdstrngfldResultstatus: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    wdstrngfldResulthandleretname: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    wdstrngfldResultstatusname: TWideStringField;
    fltfldResultdebit: TFloatField;
    dtmfldResultbilldate: TDateTimeField;
    dtmfldResulthandledate: TDateTimeField;
    dtmfldResultcreatetime: TDateTimeField;
    dtmfldResultupdatetime: TDateTimeField;
    lrgntfldResultid: TLargeintField;
    lrgntfldResultvehicleid: TLargeintField;
    lrgntfldResultorgid: TLargeintField;
    lrgntfldResultcreateby: TLargeintField;
    lrgntfldResultbillor: TLargeintField;
    cbbstatus: TNovaComboBox;
    lbl6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    vehicleviolationPrint: TNovaPrint;
    notprintValue: TList<string>; // ����ӡ��Ŀ
    printValue: TDictionary<String, String>; // ���������
    multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
  public
    { Public declarations }
    log, templtename, parameter : string;
    balance : Int64;
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;

  end;

var
  FrmVehicleviolation: TFrmVehicleviolation;

implementation

uses Services, PubFn, DateUtils;
{$R *.dfm}

procedure TFrmVehicleviolation.FormShow(Sender: TObject);
var i : Int64;
begin
  inherited;
  cbbstatus.Active := False;
  cbbstatus.Active := True;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
  i := StrToInt(getParametervalue('4008', Sysinfo.LoginUserInfo.OrgID));
  if i = 0 then
  begin
    tbtnCancel.Visible := False;
    tbtnSave.Visible := False;
    balance := 0;
    dbgrdhResult.Columns[10].Visible :=False;
    dbgrdhResult.Columns[11].Visible :=False;
    dbgrdhResult.Columns[12].Visible :=False;
    dbgrdhResult.Columns[13].Visible :=False;
    dbgrdhResult.Columns[14].Visible :=False;
    dbgrdhResult.Columns[6].Title.Caption := '����';
    lbl4.Visible := False;
    chkhandle.Visible := False;
    chkishandle.Visible := False;
    nvhlphandle.Visible := False;
  end else
  begin
    balance := 1;
    dbgrdhResult.Columns[6].Title.Caption := '�ݿۿ�';
  end;
end;


procedure TFrmVehicleviolation.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  //����
  if GUIDToString(key)='{B587536B-8BC7-4EF0-8845-46914E7821A5}' then
  begin
    tbtnSave.Visible:=aEnable;
  end ;
  //���
  if GUIDToString(key)='{27D0BD48-9B75-4459-B361-4DD899360A53}' then
  begin
    tbtnInsert.Visible:=aEnable;
  end ;
  //ɾ��
  if GUIDToString(key)='{83E9210E-EC4A-4452-8C34-26D93674570B}' then
  begin
    tbtnDelete.Visible:=aEnable;
  end ;
  //�޸�
  if GUIDToString(key)='{80967894-E79E-43A4-B208-2D5F1A09C074}' then
  begin
    tbtnEdit.Visible:=aEnable;
  end ;
  //�Ѵ���
  if GUIDToString(key)='{ACC2BFA3-D2CA-4445-89D9-B05D19039DAF}' then
  begin
    chkhandle.Enabled := aEnable;
  end ;
  //δ����
  if GUIDToString(key)='{321CA664-B649-4B75-86D6-1EFFFD3744B8}' then
  begin
    chkishandle.Enabled := aEnable;
  end ;

end;

procedure TFrmVehicleviolation.tbtnCancelClick(Sender: TObject);
var multipleValueValue: TDictionary<String, String>;
    isbalance, ishandle : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with jcdsResultPrint do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_t!id'] := jcdsResult.FieldByName('id').AsString;
    Active := True;
    templtename := TNovaPrint.GetTicketModelName('����֪ͨ��', '����Υ��֪ͨ��');
    if not Assigned(vehicleviolationPrint) then
      vehicleviolationPrint := TNovaPrint.Create(self, templtename);
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
    printValue.Clear;
    printValue.Add('notenum',FieldByName('notenum').AsString);
    printValue.Add('billdate',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('billdate').AsDateTime));
    printValue.Add('billorname',FieldByName('billorname').AsString);
    printValue.Add('breachfee',FloatToStr(FieldByName('breachfee').AsFloat));
    printValue.Add('debit',FloatToStr(FieldByName('debit').AsFloat));
    printValue.Add('departtime',FieldByName('departtime').AsString);
    printValue.Add('handledate',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('handledate').AsDateTime));
    printValue.Add('handleret',jcdsResult.FieldByName('handleretname').AsString);
    printValue.Add('handlorname',FieldByName('handlorname').AsString);
   
    printValue.Add('isbalance', jcdsResult.FieldByName('statusname').AsString);
    if FieldByName('ishandle').AsBoolean = True then
      ishandle := '�Ѵ���'
    else
      ishandle := 'δ����';
    printValue.Add('ishandle', ishandle);
    printValue.Add('orgname',FieldByName('orgname').AsString);
    printValue.Add('remark',FieldByName('remark').AsString);
    printValue.Add('routename',FieldByName('routename').AsString);
    printValue.Add('vehicleno',FieldByName('vehicleno').AsString);
    printValue.Add('violationdate',FormatDateTime('yyyy-mm-dd', FieldByName('violationdate').AsDateTime));
    printValue.Add('createname',FieldByName('createname').AsString);
    printValue.Add('updatename',FieldByName('updatename').AsString);
    printValue.Add('createtime',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('createtime').AsDateTime));
    printValue.Add('updatetime',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('updatetime').AsDateTime));

    vehicleviolationPrint.SingleValue := printValue;
    vehicleviolationPrint.Print;
  end;
end;

procedure TFrmVehicleviolation.tbtnDeleteClick(Sender: TObject);
var nResult : Int64;
    sResult : String;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if StrToInt(getParametervalue('4007', Sysinfo.LoginUserInfo.OrgID))
      < (MilliSecondsBetween(Now,jcdsResult.FieldByName('createtime').AsDateTime) div 60000) then
  begin
    SysDialogs.ShowMessage('�ü�¼�Ѿ������������õ�ʱ�䣬����ɾ����');
    Exit;
  end;
  if jcdsResult.FieldByName('ishandle').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('��Υ�泵���Ѿ���������ɾ��!');
    Exit;
  end;
  if jcdsResult.FieldByName('status').AsString <> '0' then
  begin
    SysDialogs.ShowMessage('��Υ�泵���Ѿ����㣬����ɾ��!');
    Exit;
  end;
  with jcdsDelVehicleviolation do
  try
    if not SysDialogs.Confirm('��ʾ','ȷ��Ҫɾ����Ӫ�˳���Υ�洦��') then
    begin
      exit;
    end;
    Params.ParamByName('vehicleviolation.id').Value :=jcdsResult.FieldByName('id').AsString ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      log := 'ɾ������Υ�������֪ͨ����='+jcdsResult.FieldByName('notenum').AsString+
      ',��·='+jcdsResult.FieldByName('routename').AsString+',���ƺ�='+
      jcdsResult.FieldByName('vehicleno').AsString+',����ʱ��='+jcdsResult.FieldByName('departtime').AsString+
      ',������='+SysInfo.LoginUserInfo.UserName;
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('Ӫ�˳���Υ�洦��ɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmVehicleviolation.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if StrToInt(getParametervalue('4007', Sysinfo.LoginUserInfo.OrgID))
      < (MilliSecondsBetween(Now,jcdsResult.FieldByName('createtime').AsDateTime) div 60000) then
  begin
    SysDialogs.ShowMessage('�ü�¼�Ѿ������������õ�ʱ�䣬�����޸ģ�');
    Exit;
  end;
  if jcdsResult.FieldByName('ishandle').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('��Υ�泵���Ѿ����������޸�!');
    Exit;
  end;
  if Trim(jcdsResult.FieldByName('status').AsString) <> '0' then
  begin
    SysDialogs.ShowMessage('��Υ�泵���Ѿ����㣬�����޸�!');
    Exit;
  end;
  with FrmVehicleviolationEdit do
  begin
    FrmVehicleviolationEdit := TFrmVehicleviolationEdit.Create(Self);
    Caption := '�޸ĳ���Υ�洦��֪ͨ��';
    flag := true;
    if balance = 0 then
      lbl5.Caption := '����'
    else
      lbl5.Caption := '�ݿۿ�';
    id := jcdsResult.FieldByName('id').AsInteger;
    balancetype := balance;
    dtpdepartdate.DateTime := jcdsResult.FieldByName('violationdate').AsDateTime;
    nvhelpvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    edtdeparttime.DateTime := jcdsResult.FieldByName('departtime').AsDateTime;
    mmoremark.Text := jcdsResult.FieldByName('remark').AsString;
    edtdebit.Text := jcdsResult.FieldByName('debit').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsString;
    nvhelpvehicleno.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    billor := jcdsResult.FieldByName('billor').AsInteger;
    billdate := jcdsResult.FieldByName('billdate').AsDateTime;
    notenum := jcdsResult.FieldByName('notenum').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmVehicleviolation.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      if nvckbOrgid.CheckedCount = 0 then
        Params.ParamValues['filter_INS_t!orgid'] := SysInfo.LoginUserInfo.OrgIDs
      else
        Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
      Params.ParamValues['filter_GED_t!violationdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
      Params.ParamValues['filter_LED_t!violationdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
      if Trim(edtnotenum.Text) = '' then
        params.ParamValues['filter_LIKES_t!notenum'] := ''
      else
        params.ParamValues['filter_LIKES_t!notenum'] := edtnotenum.Text;
      if Trim(NHelpRoute.Text) = '' then
        params.ParamValues['filter_LIKES_t!routename'] := ''
      else
        params.ParamValues['filter_LIKES_t!routename'] := NHelpRoute.Text;
      if Trim(nvhelpvehicleno.Text) = '' then
        params.ParamValues['filter_EQL_t!vehicleid'] := ''
      else
        params.ParamValues['filter_EQL_t!vehicleid'] := nvhelpvehicleno.Id;
      if Trim(nvhlphandle.Text) = '' then
        params.ParamValues['filter_EQL_t!handlor'] := ''
      else
        params.ParamValues['filter_EQL_t!handlor'] := nvhlphandle.Id;
      if ((chkhandle.Checked) and (chkishandle.Checked = false)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := 'true';
      end
      else if ((chkhandle.Checked = false) and (chkishandle.Checked)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := 'false';
      end
      else if ((chkhandle.Checked) and (chkishandle.Checked)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := null;
      end
      else if ((chkhandle.Checked = false) and (chkishandle.Checked = false)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := null;
      end;
      Params.ParamValues['filter_EQS_t!balancetype'] := balance;
      if Trim(cbbstatus.Text) = '' then
        Params.ParamValues['filter_EQS_t!status'] := ''
      else
        params.ParamValues['filter_EQS_t!status'] := TCommInfo(cbbstatus.Items.Objects[cbbstatus.ItemIndex]).Value;
    Active := True;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[��λ���]��'+nvckbOrgid.Text;
    if Trim(cbbstatus.Text) <> '' then
      log  := log +',[״̬]:'+cbbstatus.Text;
    if NHelpRoute.Id <> 0 then
      log := log +'[��·]��'+NHelpRoute.Text;
    if nvhelpvehicleno.Id <> 0 then
      log:= log+',[����]:'+nvhelpvehicleno.Text;
    if edtnotenum.Text <>'' then
      log := log +',[֪ͨ����]:'+edtnotenum.Text;
    if chkhandle.Checked then
      log := log +',[�Ѵ���]';
    if chkishandle.Checked then
      log := log+',[δ����]';
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->Ӫ�˳���Υ�洦��','��ѯ',log);
  end;
end;

procedure TFrmVehicleviolation.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmVehicleviolationEdit do
  begin
    FrmVehicleviolationEdit := TFrmVehicleviolationEdit.Create(Self);
    Caption := '��ӳ���Υ�洦��֪ͨ��';
    flag := true;
    dtpdepartdate.DateTime := Now;
    balancetype := balance;
    if balance = 0 then
      lbl5.Caption := '����'
    else
      lbl5.Caption := '�ݿۿ�';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmVehicleviolation.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('ishandle').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('�ó���Υ��֪ͨ���Ѿ�������ѡ����������!');
    Exit;
  end;
  with FrmVehicleviolationProcess do
  begin
    FrmVehicleviolationProcess := TFrmVehicleviolationProcess.Create(Self);
    Caption := '������Υ��֪ͨ��';
    flag := true;
    id := jcdsResult.FieldByName('id').AsInteger;
    dtpdepartdate.DateTime := jcdsResult.FieldByName('violationdate').AsDateTime;
    nvhelpvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    edtdeparttime.DateTime := jcdsResult.FieldByName('departtime').AsDateTime;
    nvhelpvehicleno.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
