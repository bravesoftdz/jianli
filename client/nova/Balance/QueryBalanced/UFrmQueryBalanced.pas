unit UFrmQueryBalanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services, NovaPrint,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic, Generics.Collections,
  NovaHComboBox, UFrmBalaceDetail,UFrmQryBalancedetailPrint,AcReport_TLB,AcRptUtils2,
  OleServer,UFrmQryCollectdetail;

type
  TfrmQueryBalanced = class(TSimpleCRUDForm)
    jcdsSchedulestatus: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    nvcbbNovaCkbOrg: TNovaCheckedComboBox;
    dtpBalancedStart: TDateTimePicker;
    dtpBalancedEnd: TDateTimePicker;
    NovaHelpUnit: TNovaHelp;
    NovaEdtInvoicesno: TNovaEdit;
    nvhelpUserid: TNovaHelp;
    lbl8: TLabel;
    lbl4: TLabel;
    NovaEditIP: TNovaEdit;
    jscdcancelBalance: TjsonClientDataSet;
    Label1: TLabel;
    cbbStatus: TComboBox;
    jscdQryDeducts: TjsonClientDataSet;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    lbl6: TLabel;
    nvhlpvehicle: TNovaHelp;
    jcdsisHaveDepartinvoice: TjsonClientDataSet;
    jcdsQryTotalDetail: TjsonClientDataSet;
    DataSource2: TDataSource;
    AcRptEngineTotalDeatil: TAcRptEngine;
    btn1: TToolButton;
    NovaHelpContractor: TNovaHelp;
    jcdsbalanceACPrint: TjsonClientDataSet;
    DataSource3: TDataSource;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    function StringToDateTime(ADateTimeStr: string): TDateTime;
    procedure tbtnbalancedetailClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    deductprinttype: String;
    parameter: String;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
    multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
    multipleValueValue: TDictionary<String, String>;
    rpt_path:string;
    parameter4017 : Boolean;

    procedure balanceACPrint(balanceid: Int64);
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  frmQueryBalanced: TfrmQueryBalanced;

implementation

uses SystemInstance, SysInfoIntf, PubFn,DateUtils;
{$R *.dfm}

procedure TfrmQueryBalanced.tbtnbalancedetailClick(Sender: TObject);
var
  baid: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;

  baid := jcdsResult.FieldByName('id').AsString;
  FrmQryCollectdetail:=TFrmQryCollectdetail.Create(Self);
  with FrmQryCollectdetail do
  begin

    with jcdsResultdetail do
    begin
      Active := False;
      Params.ParamValues['balanceid'] := baid;
      Active := True;
    end;
     ShowModal;
  end;
end;

procedure TfrmQueryBalanced.btn1Click(Sender: TObject);
var
  baid: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  baid := jcdsResult.FieldByName('id').AsString;
  FrmQryCollectdetail:= TFrmQryCollectdetail.Create(self);
  with FrmQryCollectdetail do
  begin
    caption := '���㵥��ϸ��Ϣ';
    with jcdsResultdetail do
    begin
      Active := False;
      Params.ParamValues['balanceid'] := baid;
      Active := True;
    end;
    ShowModal;
  end;
end;

procedure TfrmQueryBalanced.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbNovaCkbOrg.Active := False;
  nvcbbNovaCkbOrg.Active := True;
//  NovaHelpUnit.Active:=false;
//  NovaHelpUnit.Active:=true;
  dtpBalancedStart.Date := Now;
  dtpBalancedEnd.Date := Now;
  AcRptEngineTotalDeatil := TAcRptEngine.Create(nil);
//  rpt_path := ExtractFilePath(ParamStr(0)) + '\reports\';
  rpt_path := ExtractFilePath(ParamStr(0));
  parameter4017:= getParametervalue('4017', SysInfo.LoginUserInfo.OrgID) = '1';
end;

procedure TfrmQueryBalanced.FormShow(Sender: TObject);
var
  balancetype: string;
  isHaveDepart: integer;
begin
  inherited;
  parameter := getParametervalue('4005', SysInfo.LoginUserInfo.OrgID);
  balancetype := getParametervalue('4008', SysInfo.LoginUserInfo.OrgID);
  deductprinttype := getParametervalue('4012', SysInfo.LoginUserInfo.OrgID);
  if balancetype = '0' then
  begin
    dbgrdhResult.Columns[17].Visible := False;
    dbgrdhResult.Columns[16].Title.caption := 'Υ�淣��';
  end
  else
  begin
    dbgrdhResult.Columns[17].Visible := True;
    dbgrdhResult.Columns[16].Title.caption := '�ݿ۽��';
  end;
  with jcdsisHaveDepartinvoice do
  begin
    Active := False;
    Active := True;
    if RecordCount>0 then
    begin
       isHaveDepart := FieldByName('isHaveDepart').AsInteger;
       if isHaveDepart=1 then
       begin
           tbtnSave.Visible:=true;
           tbtnCancel.Visible:=true;
       end
       else
       begin
           tbtnSave.Visible:=false;
           tbtnCancel.Visible:=false;
       end;

    end
    else
    begin
       tbtnSave.Visible:=false;
       tbtnCancel.Visible:=false;
    end;
  end;
  dbgrdhResult.GridUser := Sysinfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryBalanced.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  // ����
  if GUIDToString(Key) = '{2894E405-46C9-4D0D-A2EF-FAB7FF57DB16}' then //
  begin
    tbtnInsert.Visible := aEnable;
  end;
  // ע��
  if GUIDToString(Key) = '{98EFEEED-5C79-48B0-966D-AB0A5645CDE3}' then //
  begin
    tbtnDelete.Visible := aEnable;
  end;
  // ·����ϸ
  if GUIDToString(Key) = '{D6261953-A6D0-4B47-BB44-D08B87A2356D}' then //
  begin
    tbtnSave.Visible := aEnable;
  end;
  // ·����ϸ��ӡ
  if GUIDToString(Key) = '{9D9DDDA1-FCCF-4862-9BB5-4CDE85B26A1B}' then //
  begin
    tbtnCancel.Visible := aEnable;
  end;

end;

procedure TfrmQueryBalanced.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  // ��ѯ�۷���ϸ
  with jscdQryDeducts do
  begin
    Active := False;
    Params.ParamValues['balanceid'] := jcdsResult.FieldByName('id').AsString;
    Active := True;
    if recordcount = 0 then
      jscdQryDeducts.Close;
  end;
end;

procedure TfrmQueryBalanced.tbtnCancelClick(Sender: TObject);
var
 ADataset: TDataset;
 actualbalanceprice : string;
 totaldeductfee : Currency;
begin
   if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('�ý���֪ͨ���Ѿ�ע����');
    exit;
  end;
  totaldeductfee := 0;
  with jcdsQryTotalDetail do
  begin
    Active := false;
     Params.ParamValues['balanceid'] :=jcdsResult.FieldByName('id').AsLargeInt;
    Active := true;
    if RecordCount>0 then
    begin
       ADataset:=DataSource2.DataSet;
       AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');
       AcRptEngineTotalDeatil.SetReportFile(rpt_path+'departdetail.apt');
       AcRptEngineTotalDeatil.AddGlobalVariable('fromdepart', FormatDateTime
      ('yyyy-mm-dd', jcdsResult.FieldByName('departstartdate').AsDateTime));
       AcRptEngineTotalDeatil.AddGlobalVariable('todepart', FormatDateTime
      ('yyyy-mm-dd', jcdsResult.FieldByName('departenddate').AsDateTime));
       AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', jcdsResult.FieldByName('balanceno').AsString);
       if jcdsResult.FieldByName('balanceobject').AsString = '0' then
       begin
          AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit', jcdsResult.FieldByName('objectname').AsString);
      end
      else
      begin
         AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit', jcdsResult.FieldByName('vehicleno').AsString);
      end;

       AcRptEngineTotalDeatil.AddGlobalVariable('invoincenum', jcdsResult.FieldByName('invoicesnum').AsString);
       with jscdQryDeducts do
      begin
        Active := False;
        Params.ParamValues['balanceid'] := jcdsResult.FieldByName('id').AsLargeInt;
        Active := True;
        if recordcount > 0 then
        begin
          first;
          while (not eof) do
          begin
             totaldeductfee := totaldeductfee + StrToCurr(FieldByName('deductmoney').AsString);
            next;
          end;
        end;
      end;

       AcRptEngineTotalDeatil.AddGlobalVariable('deductfee', totaldeductfee);

       AcRptEngineTotalDeatil.AddGlobalVariable('balancedate',jcdsResult.FieldByName('balancemonth').AsString);
     AcRptEngineTotalDeatil.AddGlobalVariable('actualbalancepriceDaxie', moneyToChinaStr(StrToCurr(jcdsResult.FieldByName('balancemoney').AsString)));
     AcRptEngineTotalDeatil.AddGlobalVariable('actualbalanceprice', jcdsResult.FieldByName('balancemoney').AsString);
      AcRptEngineTotalDeatil.AddGlobalVariable('strroutename', jcdsResult.FieldByName('routename').AsString);

//       AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
       AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ
    end;

  end;

end;

procedure TfrmQueryBalanced.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult,strdate: String;
  curid,daylimit,betweenday: Int64;
  startdate,enddate:TDateTime;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.recordcount = 0) then
  begin
    exit;
  end;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('�ý���֪ͨ���Ѿ�ע����');
    exit;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫע���ý���֪ͨ����') then
    exit;
  //���Ӳ���4016 ���ƿ���ע����ʱ������
  if (getParametervalue('4016', SysInfo.LoginUserInfo.OrgID)<>'0') then
  begin
    daylimit:= strtoint(getParametervalue('4016', SysInfo.LoginUserInfo.OrgID));
    strdate := jcdsResult.FieldByName('balancemonth').AsString+' '+jcdsResult.FieldByName('balancetime').AsString;
    startdate:= Self.StringToDateTime(strdate);
    enddate:=Self.StringToDateTime(FormatDateTime('yyyy-mm-dd hh:mm:ss',Now));
    betweenday:= DaysBetween(startdate, enddate);
    if daylimit<>0 then
    begin
      if (betweenday>daylimit) then
      begin
        SysDialogs.ShowMessage('ֻ��ע��'+inttostr(daylimit)+'���ڵĽ��㵥��');
         exit;
      end;
    end;
  end;

  try
    with jscdcancelBalance do
    begin
      Active := False;
      curid := jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamValues['balanceid'] := curid;
      Params.ParamValues['ip'] := SysInfo.LocalHostAddress;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end
      else
        SysDialogs.Warning(sResult);
    end;
  except
    on E: exception do
    begin
      screen.Cursor := crDefault;
      SysLog.WriteErr('ע�����˵�����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TfrmQueryBalanced.tbtnEditClick(Sender: TObject);
var
  baid: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  baid := jcdsResult.FieldByName('id').AsString;
  frmBalaceDetail := TfrmBalaceDetail.Create(self);
  with frmBalaceDetail do
  begin
    caption := '���㵥��ϸ��Ϣ';
    with jcdsResultdetial do
    begin
      Active := False;
      Params.ParamValues['filter_EQL_ds!balance.id'] := baid;
      Active := True;
    end;
    ShowModal;
  end;
end;

procedure TfrmQueryBalanced.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  if FormatDateTime('yyyymmdd',dtpBalancedStart.Date)>FormatDateTime('yyyymmdd',
     dtpBalancedEnd.Date) then
    begin
      SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������!');
      exit;
    end;

  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := False;
    if nvcbbNovaCkbOrg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_o!id'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_o!id'] := nvcbbNovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_GED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedStart.DateTime);
    Params.ParamValues['filter_LED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedEnd.DateTime) + ' 23:59:59';
    Params.ParamValues['filter_LIKES_b!balanceip'] := NovaEditIP.Text;
    Params.ParamValues['filter_EQS_b!balanceno'] := NovaEdtInvoicesno.Text;
    //�������㳵��  ���־  2015��8��12�� 10:37:40
    if nvhlpvehicle.Id <> 0 then
    begin
      Params.ParamValues['filter_LIKES_b!vehicleno'] := nvhlpvehicle.Text;
    end
    else
    begin
      Params.ParamValues['filter_LIKES_b!vehicleno'] := '';
    end;

    if (not(Trim(NovaHelpUnit.Text) = '')) and (NovaHelpUnit.Id > 0) then
    // ��λ
    begin
      Params.ParamValues['filter_EQL_b!objectid'] := NovaHelpUnit.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_b!objectid'] := '';
    end;

//    if (not(Trim(NovaHelpContractor.Text) = '')) and (NovaHelpContractor.Id > 0) then // �а���
//    begin
//      Params.ParamValues['filter_EQL_co!id'] := NovaHelpContractor.HelpFieldValue['id'];
//    end
//    else
//    begin
//      Params.ParamValues['filter_EQL_co!id'] := '';
//    end;

    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then
    // ������
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;
    if self.cbbStatus.ItemIndex = 1 then
      Params.ParamValues['filter_EQS_b!status'] := '0'
    else if cbbStatus.ItemIndex = 2 then
      Params.ParamValues['filter_EQS_b!status'] := '1'
    else
      Params.ParamValues['filter_EQS_b!status'] := null;
    Active := True;
    jcdsResult.AfterScroll := jcdsResultAfterScroll;
    if jcdsResult.recordcount > 0 then
      jcdsResultAfterScroll(nil)
    else
      jscdQryDeducts.Close;
    log := '��ѯ�����У�[��������]�� ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedStart.Date) + ' �� ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedEnd.Date);
    if Trim(nvcbbNovaCkbOrg.Text) <> '' then
      log := log + ',[��������]��' + nvcbbNovaCkbOrg.Text;
    if Trim(NovaEdtInvoicesno.Text) <> '' then
      log := log + ',[���㵥��]:' + NovaEdtInvoicesno.Text;
    if Trim(NovaEditIP.Text) <> '' then
      log := log + ',[IP]:' + NovaEditIP.Text;
    if Trim(nvhelpUserid.Text) <> '' then
      log := log + ',[������]��' + nvhelpUserid.Text;
    if Trim(NovaHelpUnit.Text) <> '' then
      log := log + ',[������λ]��' + NovaHelpUnit.Text;
    if Trim(NovaHelpContractor.Text) <> '' then
      log := log + ',[�а���]��' + NovaHelpContractor.Text;

    log := log + '��[��ѯ���]:���� ' + inttostr(recordcount) + ' ����¼��';
    SysLog.WriteLog('�������->�ѽ����ѯ', '��ѯ', log);
  end;end;procedure TfrmQueryBalanced.balanceACPrint(balanceid: Int64);var
  ADataset1: TDataSet;
begin
  inherited;
  with jcdsbalanceACPrint do
  begin
     Active := false;
     Params.ParamValues['balanceid'] := balanceid;
     Active := true;
//    if RecordCount>0 then
//    begin
     ADataset1:=DataSource3.DataSet;
     AddCommonDatasetToAcReport(ADataset1,AcRptEngineTotalDeatil,'detail');
     AcRptEngineTotalDeatil.SetReportFile(rpt_path+'BalanceACPrint.apt');
     AcRptEngineTotalDeatil.AddGlobalVariable('stationname',  SysInfo.LoginUserInfo.ticketoutletsname);  // ��վ���
     AcRptEngineTotalDeatil.AddGlobalVariable('stationfullname', SysInfo.LoginUserInfo.OrgName + '�������������ܵ�');  //��վȫ��
     AcRptEngineTotalDeatil.AddGlobalVariable('qryfromdate', formatdatetime('yyyy-mm-dd', dtpBalancedStart.DateTime)); //��ѯ��ʼʱ��
     AcRptEngineTotalDeatil.AddGlobalVariable('qrytodate', formatdatetime('yyyy-mm-dd', dtpBalancedEnd.DateTime));     //��ѯ����ʱ��
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit',jcdsResult.FieldByName('objectname').AsString); // ���㵥λ
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);  //����
     //������              floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)-strtofloat(NovaEdtstationservicefee.Text) * (1 - divide))
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamount', jcdsResult.FieldByName('dibalanceablemoney').AsString);
     //���㵥����
     AcRptEngineTotalDeatil.AddGlobalVariable('depcount', jcdsResult.FieldByName('invoicesnum').AsString);
     //���˴����                                                   floattostr(strtofloat(NovaEdtagentfee.Text) * divide)
     AcRptEngineTotalDeatil.AddGlobalVariable('agentfee', floattostr(jcdsResult.FieldByName('diagentfee').asfloat*jcdsResult.FieldByName('divide').asFloat));
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno',jcdsResult.FieldByName('balanceno').AsString );
//         AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
     AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ

//    end;
  end;

  ModalResult := mrok;

end;
procedure TfrmQueryBalanced.tbtnInsertClick(Sender: TObject);
var
  balanceid: Int64;
  deductifee,deductifee1, ticketitemsum, divide, stationfee, otherfee, agentfee,
    invoicesamount, ditotalmoney, returnmoney, packmoney, packprice,
    additionfee, dideductmoney, packdeduct, totalincome, actdeduct,totalprice,
    dibalanceablemoney, dibalancemoney, ticketincome, leavebalancemoney,
    balancemoney, nottickeitemdeduct,noItemAndagentdeduct,
     rentmoney, rentprice, rentdeduct, debit,
    preupmoney, lost, lateforfeit, deratemoney, ticketitemagentfeesum: Double;
  vehicleno, itemcode: String;
begin
  inherited;
  // showmessage(currtostr(NvDbgridEh1.SumList.SumCollection.Items[0].SumValue));
  // showmessage(currtostr(NvDbgridEh1.SumList.SumCollection.Items[1].SumValue));
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('�ý���֪ͨ���Ѿ�ע����');
    exit;
  end;

  try
    balanceid := jcdsResult.FieldByName('id').AsLargeInt;
    if parameter4017 then
    begin
      balanceACPrint(balanceid);
    end
    else
    begin
      if not Assigned(printValue) then
        printValue := TDictionary<String, String>.Create
      else
        printValue.Clear;
      if not Assigned(billPrint) then
        billPrint := TNovaPrint.Create(self,
          TNovaPrint.GetTicketModelName('����֪ͨ��', '����֪ͨ��'));
      divide := jcdsResult.FieldByName('divide').asFloat;
      ticketitemsum := jcdsResult.FieldByName('fueladditionfee')
        .asFloat + jcdsResult.FieldByName('distationservicefee')
        .asFloat + jcdsResult.FieldByName('diotherpredeductifee').asFloat;
      printValue.Add('invoincenum',
        jcdsResult.FieldByName('invoicesnum').AsString);
      // Ʊ�۷�����˴���ѿ۷�
      printValue.Add('ticketitemsum', floattostr(ticketitemsum * (1 - divide)));
      if jcdsResult.FieldByName('balanceobject').AsString = '0' then
      begin
        printValue.Add('balanceunit',
          jcdsResult.FieldByName('objectname').AsString);
      end
      else
      begin
        printValue.Add('balanceunit',
          jcdsResult.FieldByName('vehicleno').AsString);
      end;
      printValue.Add('balanceno', jcdsResult.FieldByName('balanceno').AsString);
      vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
      if length(vehicleno) > 15 then
        // 7*5+4
        vehicleno := copy(vehicleno, 0, 15) + '��';
      printValue.Add('vehicleno', vehicleno); //jcdsResult.FieldByName('balancemonth').asDatetime
      printValue.Add('balancedate', jcdsResult.FieldByName('balancemonth').AsString);

      printValue.Add('ditotalnum', jcdsResult.FieldByName('ditotalnum').AsString);
      // ��Ʊ����
      ditotalmoney := jcdsResult.FieldByName('ditotalmoney').asFloat;
      printValue.Add('ditotalmoney', floattostr(ditotalmoney * (1 - divide)));

      // վ���
      stationfee := jcdsResult.FieldByName('distationservicefee').asFloat;
      printValue.Add('stationfee', floattostr(stationfee * (1 - divide)));

      printValue.Add('nostationfeetotalmoney',floattostr(ditotalmoney-stationfee));
      // �����۷�
      otherfee := jcdsResult.FieldByName('diotherpredeductifee').asFloat;
      printValue.Add('otherfee', floattostr(otherfee * (1 - divide)));
      // ���˴����
      agentfee := jcdsResult.FieldByName('diagentfee').asFloat;
      printValue.Add('agentfee', floattostr(agentfee * (1 - divide)));
      ticketitemagentfeesum := ticketitemsum + agentfee;
      printValue.Add('ticketitemagentfeesum', floattostr(ticketitemagentfeesum));
      invoicesamount := ditotalmoney - stationfee - jcdsResult.FieldByName
        ('fueladditionfee').asFloat - otherfee;
      // 'Ʊ��-Ʊ�۷���',0,'invoicesamount'
      printValue.Add('invoicesamount', floattostr(invoicesamount * (1 - divide)));

      returnmoney := jcdsResult.FieldByName('returnmoney').asFloat;
      printValue.Add('returnmoney', floattostr(returnmoney));

      packmoney := jcdsResult.FieldByName('packmoney').asFloat;
      printValue.Add('packmoney', floattostr(packmoney));
      packprice := jcdsResult.FieldByName('packprice').asFloat;
      printValue.Add('packprice', floattostr(packprice));
      packdeduct := packprice - packmoney;

      // �а������',0,'packdeduct
      printValue.Add('packdeduct', floattostr(packdeduct));

      // ����Ӫ��
      rentmoney := jcdsResult.FieldByName('rentmoney').asFloat;
      printValue.Add('rentmoney', floattostr(rentmoney));
      // ����Ӧ��
      rentprice := jcdsResult.FieldByName('rentprice').asFloat;
      printValue.Add('rentprice', floattostr(rentprice));
      rentdeduct := rentmoney - rentprice;
      // ���������',0,'rentdeduct
      printValue.Add('rentdeduct', floattostr(rentdeduct));

      lost := jcdsResult.FieldByName('lost').asFloat;
      preupmoney := jcdsResult.FieldByName('preupmoney').asFloat;
      // Ӫ��С��',0,'totalincome =Ʊ��-Ʊ�۷���-agentfee+�а����+�س̽�����
      totalincome := invoicesamount * (1 - divide) -agentfee-
        + preupmoney - lost + returnmoney + packprice + rentmoney;
      printValue.Add('totalincome', floattostr(totalincome));
      // վ�񸽼ӷ�
      additionfee := jcdsResult.FieldByName('additionfee').asFloat;
      printValue.Add('additionfee', floattostr(additionfee * (1 - divide)));

      // �ֹ��۷�
      dideductmoney := jcdsResult.FieldByName('dideductmoney').asFloat;
      printValue.Add('dideductmoney', floattostr(dideductmoney));

      deductifee := jcdsResult.FieldByName('fueladditionfee')
        .asFloat + jcdsResult.FieldByName('diagentfee')
        .asFloat + jcdsResult.FieldByName('distationservicefee')
        .asFloat + jcdsResult.FieldByName('diotherpredeductifee')
        .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
      // �ܿ۷�=���ֹ�����۷Ѳ�����ֳ�
      printValue.Add('deductifee',
        floattostr(deductifee * (1 - divide) + dideductmoney + packdeduct +
            rentdeduct));
      totalprice:=ditotalmoney+packprice  +rentmoney;
      printValue.Add('totalprice', floattostr(totalprice * (1 - divide))); //������
      actdeduct:=deductifee * (1 - divide) + dideductmoney
                +packdeduct+rentdeduct;
      printValue.Add('actdeduct', floattostr(actdeduct * (1 - divide))); //ʵ�۽��
      // �ܿɽ�����=�����Ľ�����(1-�ֳ�)=�ܽ�����*(1-�ֳ�)
      // =Ʊ����-վ���-ȼ�ͷ�-�����۷�-���˴����* (1-�ֳ�)
      dibalanceablemoney := jcdsResult.FieldByName('dibalanceablemoney').asFloat *
        (1 - divide);
      printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

      // dibalancemoney Ӧ���� = �ܿɽ�����-�ֹ��۷�
      // dibalancemoney := dibalanceablemoney - dideductmoney;
      dibalancemoney := jcdsResult.FieldByName('dibalancemoney').asFloat;
      printValue.Add('dibalancemoney', floattostr(dibalancemoney));
      debit := jcdsResult.FieldByName('debit').asFloat;
      // ��Ʊ�۷�����۷�
      nottickeitemdeduct := jcdsResult.FieldByName('diagentfee')
        .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
      lateforfeit := jcdsResult.FieldByName('lateforfeit').asFloat;
      nottickeitemdeduct := nottickeitemdeduct * (1 - divide)
        + lateforfeit + dideductmoney + packdeduct + rentdeduct + debit;
      printValue.Add('nottickeitemdeduct', floattostr(nottickeitemdeduct));
      // ��Ʊ�۷�������˴������Ŀ۷�     noItemAndagentdeduct
      printValue.Add('noItemAndagentdeduct',currtostr(nottickeitemdeduct - agentfee));
      // ����Ӫ��= Ӧ���� +\- ����������Ϣ -վ�񸽼ӷ�*��1-���˴���ѱ�����*��1-�ֳɱ�����
      ticketincome := jcdsResult.FieldByName('ticketincome').asFloat;
      printValue.Add('ticketincome', floattostr(ticketincome));

      // ʣ��Ӧ���� =����Ӫ��+�а�Ӧ��
      leavebalancemoney := ticketincome + packmoney;
      printValue.Add('leavebalancemoney', floattostr(leavebalancemoney));
      deratemoney := jcdsResult.FieldByName('deratemoney').asFloat;
      // balancemoney := jcdsResult.FieldByName('balancemoney').asFloat;
      balancemoney := totalincome - nottickeitemdeduct + deratemoney;
      // ʵ���� = ʣ��Ӧ����
  //    printValue.Add('balancemoney', currtostr(balancemoney));
      printValue.Add('balancemoney', jcdsResult.FieldByName('balancemoney').AsString);
      // ������
      printValue.Add('deratemoney', floattostr(deratemoney));
      printValue.Add('routename', jcdsResult.FieldByName('routename').AsString);
      printValue.Add('vipscoremoney',
        jcdsResult.FieldByName('vipscoremoney').AsString);
      printValue.Add('preupmoney', jcdsResult.FieldByName('preupmoney').AsString);
      printValue.Add('lateforfeit',
        jcdsResult.FieldByName('lateforfeit').AsString);
      printValue.Add('lostforfeit',
        jcdsResult.FieldByName('lostforfeit').AsString);
      printValue.Add('lastlost', jcdsResult.FieldByName('lastlost').AsString);
      printValue.Add('lost', jcdsResult.FieldByName('lost').AsString);
      printValue.Add('remarks', jcdsResult.FieldByName('remarks').AsString);
      printValue.Add('departstartdate',
        jcdsResult.FieldByName('departstartdate').AsString);
      printValue.Add('departenddate',
        jcdsResult.FieldByName('departenddate').AsString);
      printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('debit', jcdsResult.FieldByName('debit').AsString);
      printValue.Add('backmoney', jcdsResult.FieldByName('backmoney').AsString);

       deductifee1 := jcdsResult.FieldByName('fueladditionfee')
        .asFloat + jcdsResult.FieldByName('diagentfee')
        .asFloat + jcdsResult.FieldByName('diotherpredeductifee')
        .asFloat + jcdsResult.FieldByName('additionfee').asFloat;

      //���˴����
      printValue.Add('hydlffee', jcdsResult.FieldByName('goodsagent').AsString);
      //�����Ͻ�
      printValue.Add('bysj', jcdsResult.FieldByName('bysj').AsString);
      //����Ƿ��
      printValue.Add('syqj', jcdsResult.FieldByName('syqj').AsString);
      //�ܿ۷�1 =  ԭ�ܿ۷ѻ���ȥ��վ���
      printValue.Add('deductifee1',
        floattostr(deductifee1 * (1 - divide) + dideductmoney + packdeduct +
            rentdeduct));

      // ticketitemsum:=0;
      // ��ѯ�۷���ϸ
      if deductprinttype = '0' then
      begin
        with jscdQryDeducts do
        begin
          if Active and (recordcount > 0) then
          begin
            first;
            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            while (not eof) do
            begin
              multipleValueValue := TDictionary<String, String>.Create;
              multipleValueValue.Add('deductname', FieldByName('name').AsString);
              multipleValueValue.Add('deductfee',
                FieldByName('deductmoney').AsString);
              multiplelist.Add(multipleValueValue);
              next;
            end;
            billPrint.MultipleValue := multiplelist;
          end;
          billPrint.SingleValue := printValue;
          billPrint.Print;
        end;
      end
      else
      begin
        with jscdQryDeducts do
        begin
          Active := False;
          Params.ParamValues['balanceid'] := balanceid;
          Active := True;
          if recordcount > 0 then
          begin
            first;
            while (not eof) do
            begin
              itemcode := FieldByName('code').AsString;
              printValue.Add(itemcode, FieldByName('deductmoney').AsString);
              next;
            end;
          end;
        end;
        billPrint.SingleValue := printValue;
        billPrint.Print;
      end;
      if divide > 0 then
      begin
        printValue.Clear;
        printValue.Add('invoincenum',
          jcdsResult.FieldByName('invoicesnum').AsString);
        // Ʊ�۷�����˴���ѿ۷�
        printValue.Add('ticketitemsum', floattostr(ticketitemsum * divide));
        printValue.Add('balanceunit',
          jcdsResult.FieldByName('dividename').AsString);
        printValue.Add('balanceno', jcdsResult.FieldByName('balanceno').AsString);
        printValue.Add('vehicleno', jcdsResult.FieldByName('vehicleno').AsString);
        printValue.Add('balancedate', formatdatetime('yyyy-mm-dd',
            jcdsResult.FieldByName('balancetime').AsDateTime));

        printValue.Add('ditotalnum',
          jcdsResult.FieldByName('ditotalnum').AsString);
        // ��Ʊ����
        ditotalmoney := jcdsResult.FieldByName('ditotalmoney').asFloat;
        printValue.Add('ditotalmoney', floattostr(ditotalmoney * divide));

        // վ���
        stationfee := jcdsResult.FieldByName('distationservicefee').asFloat;
        printValue.Add('stationfee', floattostr(stationfee * divide));
        // �����۷�
        otherfee := jcdsResult.FieldByName('diotherpredeductifee').asFloat;
        printValue.Add('otherfee', floattostr(otherfee * divide));
        // ���˴����
        agentfee := jcdsResult.FieldByName('diagentfee').asFloat;
        printValue.Add('agentfee', floattostr(agentfee * divide));
        printValue.Add('ticketitemagentfeesum',
          floattostr(ticketitemsum * divide + agentfee * divide));
        invoicesamount := ditotalmoney - stationfee - jcdsResult.FieldByName
          ('fueladditionfee').asFloat - otherfee;
        // 'Ʊ��-Ʊ�۷���',0,'invoicesamount'
        printValue.Add('invoicesamount', floattostr(invoicesamount * divide));

        returnmoney := 0;
        printValue.Add('returnmoney', floattostr(returnmoney));

        packmoney := 0;
        printValue.Add('packmoney', floattostr(packmoney));
        packprice := 0;
        printValue.Add('packprice', floattostr(packprice));

        packdeduct := packprice - packmoney;
        // �а������',0,'packdeduct
        printValue.Add('packdeduct', floattostr(packdeduct));

        // ����Ӫ��
        rentmoney := 0;
        printValue.Add('rentmoney', floattostr(rentmoney));
        // ����Ӧ��
        rentprice := 0;
        printValue.Add('rentprice', floattostr(rentprice));
        rentdeduct := rentmoney - rentprice;
        // ���������',0,'rentdeduct
        printValue.Add('rentdeduct', floattostr(rentdeduct));

        // Ӫ��С��',0,'totalincome =Ʊ��-Ʊ�۷���+�а����+�س̽�����
        totalincome := invoicesamount * divide + returnmoney + packprice;
        printValue.Add('totalincome', floattostr(totalincome));

        // վ�񸽼ӷ�
        additionfee := jcdsResult.FieldByName('additionfee').asFloat;
        printValue.Add('additionfee', floattostr(additionfee * divide));

        // �ֹ��۷�
        dideductmoney := NvDbgridEh1.SumList.SumCollection.Items[1].SumValue;
        printValue.Add('dideductmoney', floattostr(dideductmoney));

        deductifee := jcdsResult.FieldByName('fueladditionfee')
          .asFloat + jcdsResult.FieldByName('diagentfee')
          .asFloat + jcdsResult.FieldByName('distationservicefee')
          .asFloat + jcdsResult.FieldByName('diotherpredeductifee')
          .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
        // �ܿ۷�=���ֹ�����۷Ѳ�����ֳ�
        printValue.Add('deductifee',
          floattostr(deductifee * divide + dideductmoney));
        // ��Ʊ�۷�����۷�
        nottickeitemdeduct := jcdsResult.FieldByName('diagentfee')
          .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
        nottickeitemdeduct := nottickeitemdeduct * divide + dideductmoney;
        // ��Ʊ�۷�����۷�
        printValue.Add('nottickeitemdeduct', floattostr(nottickeitemdeduct));

        // �ܿɽ�����=�����Ľ�����(1-�ֳ�)=�ܽ�����*(1-�ֳ�)
        // =Ʊ����-վ���-ȼ�ͷ�-�����۷�-���˴����* (1-�ֳ�)
        dibalanceablemoney := jcdsResult.FieldByName('dibalanceablemoney')
          .asFloat * divide;
        printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

        // dibalancemoney Ӧ���� = �ܿɽ�����-�ֹ��۷�
        // dibalancemoney := dibalanceablemoney - dideductmoney;
        dibalancemoney := jcdsResult.FieldByName('dibalancemoney').asFloat;
        printValue.Add('dibalancemoney', floattostr(dibalancemoney));

        // ����Ӫ��= Ӧ���� +\- ����������Ϣ -վ�񸽼ӷ�*��1-���˴���ѱ�����*��1-�ֳɱ�����
        ticketincome := jcdsResult.FieldByName('ticketincome').asFloat;
        printValue.Add('ticketincome', floattostr(ticketincome));
        packmoney := 0;
        // ʣ��Ӧ���� =����Ӫ��+�а�Ӧ��
        leavebalancemoney := ticketincome + packmoney;
        printValue.Add('leavebalancemoney', floattostr(leavebalancemoney));

        // balancemoney := jcdsResult.FieldByName('balancemoney').asFloat;
        balancemoney := totalincome - nottickeitemdeduct;
        // ʵ���� = ʣ��Ӧ����
        printValue.Add('balancemoney', floattostr(balancemoney));

        printValue.Add('routename', jcdsResult.FieldByName('routename').AsString);
        printValue.Add('vipscoremoney', '0');
        printValue.Add('preupmoney', '0');
        printValue.Add('lateforfeit', '0');
        printValue.Add('lostforfeit', '0');
        printValue.Add('lastlost', '0');
        printValue.Add('lost', '0');
        printValue.Add('remarks', jcdsResult.FieldByName('remarks').AsString);
        printValue.Add('departstartdate',
          jcdsResult.FieldByName('departstartdate').AsString);
        printValue.Add('departenddate',
          jcdsResult.FieldByName('departenddate').AsString);
        printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);

        with jscdQryDeducts do
        begin
          if Active and (recordcount > 0) then
          begin
            first;
            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            while (not eof) do
            begin
              multipleValueValue := TDictionary<String, String>.Create;
              multipleValueValue.Add('deductname', FieldByName('name').AsString);
              multipleValueValue.Add('deductfee',
                FieldByName('divdedeductmoney').AsString);
              multiplelist.Add(multipleValueValue);
              next;
            end;
            billPrint.MultipleValue := multiplelist;
          end;
        end;
        billPrint.SingleValue := printValue;
        billPrint.Print;
      end;
    end;

  except
    on E: exception do
    begin
      SysLog.WriteErr('��ӡ���ʵ�ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TfrmQueryBalanced.tbtnSaveClick(Sender: TObject);
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  frmQryBanlancedetailPrint:=TFrmQryBanlancedetailPrint.Create(Self);
  with frmQryBanlancedetailPrint do
  begin

    with jcdsResultdetailPrint do
    begin
      Active := False;
      Params.ParamValues['balanceid'] := jcdsResult.FieldByName('id').AsString;
      Active := True;
    end;
     ShowModal;
  end;
end;

// ���ַ�����ʽ"yyyy-mm-dd hh:mm:ss" ת��Ϊ����ʱ���ʽ
function TfrmQueryBalanced.StringToDateTime(ADateTimeStr: string): TDateTime;
var
  AFormatSettings: TFormatSettings;
  ShortDateFormat, ShortTimeFormat: string;
  DateSeparator, TimeSeparator: char;
begin
  ShortDateFormat := 'yyyy-MM-dd';
  DateSeparator := '-';
  ShortTimeFormat := 'HH:mm:ss';
  TimeSeparator := ':';
  AFormatSettings.ShortDateFormat := ShortDateFormat;
  AFormatSettings.DateSeparator := DateSeparator;
  AFormatSettings.ShortTimeFormat := ShortTimeFormat;
  AFormatSettings.TimeSeparator := TimeSeparator;
  Result := StrToDateTime(ADateTimeStr, AFormatSettings);
end;

end.
