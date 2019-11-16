unit UFrmPackDepartinvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaComboBox, NovaEdit, NovaHelp,Generics.Collections,NovaPrint;

type
  TFrmPackDepartinvoices = class(TSimpleCRUDForm)
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpschedule: TNovaHelp;
    lbl4: TLabel;
    cbbstatus: TNovaComboBox;
    chkiscomputeno: TCheckBox;
    chknotcomputeno: TCheckBox;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    lbl1: TLabel;
    nvhlpcode: TNovaHelp;
    lbl5: TLabel;
    edtdepartinvoicesno: TNovaEdit;
    nvhlproute: TNovaHelp;
    lblroute: TLabel;
    jcdsResultCancel: TjsonClientDataSet;
    jcdsQryPackItems: TjsonClientDataSet;
    jcdsUpdatepack: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
    isAuthority,isinday,isprintbynewticketno:Boolean;
    billPackPrint: TNovaPrint;
    printPackValue: TDictionary<String, String>; // ���������
    multiplePacklist: TList < TDictionary < String, String >> ; // ������ݼ�
    multiplePackValueValue: TDictionary<String, String>;
    procedure PrintClink(scheduleid: int64;singbillno:string);
    procedure refreshBill; // ˢ��Ʊ��
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmPackDepartinvoices: TFrmPackDepartinvoices;

implementation
uses Services, PubFn,UFrmPackDepartinvoicesDetail,UFrmPackDepartinvoicesEdit,UFrmpackreprint;
{$R *.dfm}

procedure TFrmPackDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.datetime := now();
  dtpenddate.datetime := now();

  cbborg.Active := False;
  cbborg.Active := True;

  cbbstatus.Active := false;
  cbbstatus.Active := true;
end;

procedure TFrmPackDepartinvoices.tbtnDeleteClick(Sender: TObject);
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
    Params.ParamValues['departinvoices.cancelby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['departinvoices.cancelstationid'] := SysInfo.LoginUserInfo.StationID;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := 'ע���а����㵥����������='+jcdsResult.FieldByName('departdate').AsString+
        ',��·=' + jcdsResult.FieldByName('routename').AsString+
        ',���='+jcdsResult.FieldByName('schedulename').AsString + ',����='+
        jcdsResult.FieldByName('departinvoicesno').AsString + ',�������='+
        jcdsResult.FieldByName('pieces').AsString;
        SysLog.WriteLog('�а�����->�а����㵥����','ע�����㵥',log);
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', invoicesid, []);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�а����㵥������Ϣע��ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmPackDepartinvoices.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if(not jcdsResult.Active) or(jcdsResult.RecordCount=0) then
    exit;

  FrmPackDepartinvoicesDetail := TFrmPackDepartinvoicesDetail.Create(self);
  with FrmPackDepartinvoicesDetail do
  begin
    departinvoicesid := jcdsResult.FieldByName('id').AsLargeInt;
    SysMainForm.showFormModal(FrmPackDepartinvoicesDetail);
    tbtnFilterClick(self);
  end;

end;

procedure TFrmPackDepartinvoices.tbtnFilterClick(Sender: TObject);
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
    Params.ParamValues['filter_INS_t!printorgid'] := cbborg.GetSelectID;

    if (((nvhlproute.Text)<>'') and (nvhlproute.Id>0)) then
       Params.ParamValues['filter_EQL_ro!id'] := nvhlproute.Id
      else
       Params.ParamValues['filter_EQL_ro!id'] := '';
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

      if chkiscomputeno.Checked and chknotcomputeno.Checked then
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '';
    end
    else if chkiscomputeno.Checked then
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '0';
    end
    else if chknotcomputeno.Checked then
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '1';
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!datatype'] := '';
    end;

    Active := True;
  end;
end;

procedure TFrmPackDepartinvoices.tbtnInsertClick(Sender: TObject);
var invoicesid, nResult : LongWord;
    sResult, temp : string;
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

  with FrmPackDepartinvoicesEdit do
  begin
    FrmPackDepartinvoicesEdit := TFrmPackDepartinvoicesEdit.Create(Self);
    Caption := '�������㵥';
    sign := true;
    invoicesid := jcdsResult.FieldByName('id').AsInteger;
    departinvoicesid := jcdsResult.FieldByName('id').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('scheduleplanid').AsString;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsString;
    departdate := jcdsResult.FieldByName('departdate').AsString;
    reportvehicleid := jcdsResult.FieldByName('reportid').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;

    departtime:= jcdsResult.FieldByName('departtime').AsString;

    edtstartdate.Text:= jcdsResult.FieldByName('departdate').AsString;
    edtvehicletype.Text:= jcdsResult.FieldByName('vehicletypename').AsString;
    edtstartstation.Text:= jcdsResult.FieldByName('startstationname').AsString;
    edtendstation.Text:= jcdsResult.FieldByName('endstationname').AsString;
    edtunit.Text:= jcdsResult.FieldByName('unitname').AsString;
    edtplanvehicle.Text := jcdsResult.FieldByName('reportname').AsString;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    edtstarttime.Text:= jcdsResult.FieldByName('departtime').AsString;

    if jcdsResult.FieldByName('status').Value = '0' then
    begin
      isdepartinvoices := '0';
    end else
    begin
      isdepartinvoices := '';
    end;
    if SysMainForm.showFormModal(FrmPackDepartinvoicesEdit, false) = mrok then
    begin
        curid:=departinvoicesid;
        tbtnFilterClick(Self);
        jcdsResult.Locate('id', curid, []);
    end;
  end;

end;

procedure TFrmPackDepartinvoices.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ý��㵥�Ѿ����㣬�����ش�');
    Exit;
  end;
  if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ����ش������') then
  begin
    exit;
  end;

  Frmpackreprint := TFrmpackreprint.Create(self);
  try
  with Frmpackreprint do
  begin
    if SysMainForm.showFormModal(Frmpackreprint, false) = mrok then
    begin
      if isprintbynewbillno=1 then
      begin
          isprintbynewticketno:=false;
      end
      else if isprintbynewbillno=2 then
      begin
          isprintbynewticketno:=true;
      end
      else
      begin
           exit;
      end;
    end;
  end;
  finally
    FreeAndNil(Frmpackreprint);
  end;

  PrintClink(jcdsResult.FieldByName('scheduleid').AsLargeInt,jcdsResult.FieldByName('departinvoicesno').AsString);

end;

procedure TFrmPackDepartinvoices.HandleAuthority(const Key: TGUID;
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

procedure TFrmPackDepartinvoices.PrintClink(scheduleid: int64;singbillno:string);
var
  piecesnums: integer;
  totalfeemoney,balancetotalfeemoney: double;
  sendstationname: string;
begin
   try
    printPackValue := TDictionary<String, String>.Create;
    if not Assigned(billPackPrint) then
    begin
      billPackPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('������㵥', '������㵥'));
    end;
    with jcdsQryPackItems do
    begin

      Active := false;

      Params.ParamValues['startdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['enddate'] := jcdsResult.FieldByName('departdate').AsString;

      Params.ParamValues['scheduleid'] := scheduleid;

      Params.ParamValues['isbukai'] := '0'; //���ǲ���

      Params.ParamValues['filter_GED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_LED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := scheduleid;

      if isprintbynewticketno then //�º��ش�
      begin
         Params.ParamValues['isreprint'] := '1';  //�½��㵥��
          Params.ParamValues['departinvoicesno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
      end
      else
      begin
         Params.ParamValues['isreprint'] := '2'; //ԭ���㵥��
         Params.ParamValues['departinvoicesno'] := singbillno;
      end;


      Active := true;

      if RecordCount < 1 then
      begin
        //SysDialogs.ShowMessage('�ð��û���а�ǩ��!')
        exit;
      end;

      multiplePacklist := TList < TDictionary < String, String >> .Create;
      while not Eof do
      begin
        sendstationname := FieldByName('sendstationname').AsString; // ����վ
        piecesnums := piecesnums + FieldByName('pieces').AsInteger; // �а��ܼ���
        totalfeemoney := totalfeemoney + FieldByName('totalfee').AsFloat; // �ܽ��
        balancetotalfeemoney := balancetotalfeemoney + FieldByName('balancefeecountmoney').AsFloat; //�����ܽ��
        multiplePackValueValue := TDictionary<String, String>.Create;
        multiplePackValueValue.Add('tostationvalue',
          FieldByName('tostationname').AsString); // ��վ
        multiplePackValueValue.Add('pieces', FieldByName('pieces').AsString);
        // ����
        multiplePackValueValue.Add('totalfeemoney',
          FieldByName('totalfee').AsString); // ���
        multiplePackValueValue.Add('packno', FieldByName('packno').AsString);
        // �а����˵���

        multiplePackValueValue.Add('balancefeecountmoney',
          FieldByName('balancefeecountmoney').AsString); // ������
        multiplePacklist.Add(multiplePackValueValue);
        next;
      end;

    // ǩ�����š��������ڡ���κš����ƺ��롢��ʻԱ��Ӫ�˵�λ���а��������ܽ�

      printPackValue.Clear;

      if isprintbynewticketno then     //�º��ش�
      begin
        printPackValue.Add('singbillno',
          Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill']);

        with jcdsUpdatepack do
        begin

          Active := false;

          Params.ParamValues['filter_GED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['filter_LED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := scheduleid;

          Params.ParamValues['singbillno'] :=
            Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

          Execute;

        end;

        with Sysinfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue('BalanceBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill']) + 1),
              length(curBillNo.Items['BalanceBill'])));
          curBillNum.AddOrSetValue('BalanceBill',
            curBillNum.Items['BalanceBill'] - 1);
        end;
        refreshBill;

      end
      else
      begin
        printPackValue.Add('singbillno',singbillno); // ԭ���ش�
      end;

      printPackValue.Add('fillopen','�ش�');
      printPackValue.Add('departdate',Params.ParamValues['packStockVo.departdate']); // ��������
      // ����ʱ��
      printPackValue.Add('departtime', Params.ParamValues['packStockVo.departtime']);
      printPackValue.Add('schedulevalue', Params.ParamValues['packStockVo.code']); // ���
      printPackValue.Add('vehiclevalue', Params.ParamValues['packStockVo.vehicleno']);
      // ���ƺ�
      printPackValue.Add('drivername', Params.ParamValues['packStockVo.drivername']);
      // ��ʻԱ
      printPackValue.Add('unitname', Params.ParamValues['packStockVo.unitname']); // Ӫ�˵�λ
      printPackValue.Add('sellbyname', Sysinfo.LoginUserInfo.UserName); // ǩ����
      printPackValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss',
          now));
      // ǩ��ʱ��
      printPackValue.Add('sendstation', sendstationname); // ǩ��վ

      printPackValue.Add('piecesnums', inttostr(piecesnums)); // �а�����
      printPackValue.Add('totalfeecountmoney', floattostr(totalfeemoney));// �ܽ��
      printPackValue.Add('balancetotalfeecountmoney', floattostr(balancetotalfeemoney));// �����ܽ��

    end;
    billPackPrint.MultipleValue := multiplePacklist;

    billPackPrint.SingleValue := printPackValue;
    billPackPrint.Print;

  finally

  end;
end;

procedure TFrmPackDepartinvoices.refreshBill;
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (SysInfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin

  end
  else
  begin
    SysDialogs.Warning('�����ý��㵥�ţ�');
  end;
end;


end.
