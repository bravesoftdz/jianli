unit UFrmPackaccept;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmPackaccept = class(TSimpleCRUDForm)
    jcdspackwaste: TjsonClientDataSet;

    jcdsResultid: TLargeintField;
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    jcdsResultSENDSTATIONID: TLargeintField;
    jcdsResultsendstationname: TWideStringField;
    jcdsResultTOSTATIONID: TLargeintField;
    jcdsResulttostationname: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultSCHEDULEID: TLargeintField;
    jcdsResultschedulename: TWideStringField;
    jcdsResultVEHICLEID: TLargeintField;
    jcdsResultvehiclecode: TWideStringField;
    jcdsResultdepartdate: TDateTimeField;
    jcdsResultpackno: TWideStringField;
    jcdsResultinvoiceno: TWideStringField;
    jcdsResultSELLBY: TLargeintField;
    jcdsResultsellbyname: TWideStringField;
    jcdsResultpieces: TIntegerField;
    jcdsResultvolume: TWideStringField;
    jcdsResultPACKED: TWideStringField;
    jcdsResultshipprice: TFloatField;
    jcdsResultpackfee: TFloatField;
    jcdsResulthandfee: TFloatField;
    jcdsResultcustodial: TFloatField;
    jcdsResulttransitfee: TFloatField;
    jcdsResultinsuredamount: TFloatField;
    jcdsResultinsurancefee: TFloatField;
    jcdsResultinsurance: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultlocation: TWideStringField;
    jcdsResultpackprice: TFloatField;
    jcdsResultsender: TWideStringField;
    jcdsResultsenderphone: TWideStringField;
    jcdsResultsenderaddress: TWideStringField;
    jcdsResultconsignee: TWideStringField;
    jcdsResultconsigneephone: TWideStringField;
    jcdsResultconsigneeaddress: TWideStringField;
    jcdsResultcertificateno: TWideStringField;
    jcdsResultvaluables: TBooleanField;
    jcdsResultPACKTTURNOVERID: TLargeintField;
    jcdsResultremak: TWideStringField;
    jcdsResultORGID: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultupdatebyname: TWideStringField;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    Label1: TLabel;
    nvedtnames: TNovaEdit;
    Label3: TLabel;
    nvhelptostation: TNovaHelp;
    jcdspackedvalue: TjsonClientDataSet;
    jcdcertificatetypevalue: TjsonClientDataSet;
    jcdshiptypevalue: TjsonClientDataSet;
    jcdspaymethodvalue: TjsonClientDataSet;
    jcdsResultpackedvalue: TWideStringField;
    jcdsResultCERTIFICATETYPE: TWideStringField;
    jcdsResultcertificatetypevalue: TWideStringField;
    jcdsResultSHIPTYPE: TWideStringField;
    jcdsResultshiptypevalue: TWideStringField;
    jcdsResultPAYMETHOD: TWideStringField;
    jcdsResultpaymethodvalue: TWideStringField;
    jcdsstatusvalue: TjsonClientDataSet;
    jcdsResultSTATUS: TWideStringField;
    jcdsResultstatusvalue: TWideStringField;
    nvcbborg: TNovaCheckedComboBox;
    jcdsgoodtypevalue: TjsonClientDataSet;
    jcdsResultGOODTYPE: TWideStringField;
    jcdsResultgoodtypevalue: TWideStringField;
    jcdsResultdeliveryfee: TFloatField;
    jcdsResultpacktype: TWideStringField;
    Label4: TLabel;
    nvcbbpackstatus: TNovaComboBox;
    jcdsResultischoose: TBooleanField;
    jcdspacktypevalue: TjsonClientDataSet;
    jcdsResultpacktypevalue: TWideStringField;
    GroupBox2: TGroupBox;
    lbpackbill: TLabel;
    Label5: TLabel;
    lbbillnum: TLabel;
    jcdswhackpack: TjsonClientDataSet;
    jcdsupdateBillinuse: TjsonClientDataSet;
    jcdsResultweight: TFloatField;
    tmGetCurInvoinNo: TTimer;
    jcdsResultonlycode: TWideStringField;
    jcdsResultsynccode: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsUsertype: TjsonClientDataSet;
    jcdsResultclientid: TLargeintField;
    jcdsResultmobilephone: TWideStringField;
    jcdsResultclientname: TWideStringField;
    jcdsResultclientaddress: TWideStringField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultservicefee: TFloatField;
    jcdsResultintegraterprice: TFloatField;
    jcdsResultclientintegrater: TLargeintField;
    jcdsResultclientcode: TWideStringField;
    jcdsResultclienttype: TWideStringField;
    lbl1: TLabel;
    NovaEdtNum: TNovaEdit;
    Label6: TLabel;
    nvcbbpackrecycletstatus: TNovaComboBox;
    Label8: TLabel;
    nvcbbcollectstatus: TNovaComboBox;
    jcdscollectstatusname: TjsonClientDataSet;
    jcdsrecyclestatusname: TjsonClientDataSet;
    jcdsResultcollectstatus: TWideStringField;
    jcdsResultcollectstatusname: TWideStringField;
    jcdsResultrecyclestatus: TWideStringField;
    jcdsResultrecyclestatusname: TWideStringField;
    tbtnpaymentrecycle: TToolButton;
    jcdspaymentrecyclesave: TjsonClientDataSet;
    procedure tmGetCurInvoinNoTimer(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure tbtnpaymentrecycleClick(Sender: TObject);

  private
    { Private declarations }
    isprintbalance: boolean;
    ispackbill, ispacksgbill: boolean; // �ж�ǰ���Ƿ���ȡ��Ʊ�����ж����������Ʊ��
    isprint: string; // �Ƿ��ӡ���˵���
    isdrawbill: string; // �Ƿ���ȡ���˵���
    isoriginalprint: boolean; // �Ƿ�ԭƱ���ش�
    log: String;
    procedure printpack;
    procedure refreshBill;
    procedure updatepackbill;

  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
  end;

var
  FrmPackaccept: TFrmPackaccept;

implementation

uses UFrmPackacceptAdd, UFrmPackacceptReport, UFrmPackreturnback;
{$R *.dfm}

procedure TFrmPackaccept.refreshBill();
begin

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then
  begin
    lbpackbill.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
    lbbillnum.Caption := IntToStr
      (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill']);
    ispackbill := True;
  end
  else
  begin
    lbpackbill.Caption := '000000000000';
    lbbillnum.Caption := '0';
    ispackbill := False;
  end;

//  if getParametervalue('8006', Sysinfo.LoginUserInfo.OrgID) = '1' then
//  begin
//    GroupBox3.Visible := True;
//    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackSgBill')
//      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackSgBill') and
//      (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] > 0) then
//    begin
//      lbsgbill.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill'];
//      lbsgbillnum.Caption := IntToStr
//        (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill']);
//      ispacksgbill := True;
//    end
//    else
//    begin
//      lbsgbill.Caption := '000000000000';
//      lbsgbillnum.Caption := '0';
//      ispacksgbill := False;
//    end;
//    GroupBox3.Visible := True;
//  end
//  else
//    GroupBox3.Visible := False;

end;

procedure TFrmPackaccept.FormActivate(Sender: TObject);
begin
  inherited;
  NovaEdtNum.SetFocus;
end;

procedure TFrmPackaccept.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  tmGetCurInvoinNo.Enabled := False;
end;

procedure TFrmPackaccept.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbcollectstatus.Active := False;
  nvcbbcollectstatus.Active := True;
  nvcbbpackrecycletstatus.Active := False;
  nvcbbpackrecycletstatus.Active := True;
  GroupBox2.Visible := False;
  isprint := getParametervalue('8016', Sysinfo.LoginUserInfo.OrgID);
  isdrawbill := getParametervalue('8017', Sysinfo.LoginUserInfo.OrgID);
  if (isdrawbill = '1') then
  begin
    GroupBox2.Visible := True;
    if not checkBillno('PackBill') then
    begin
      SysDialogs.ShowInfo('δ���а����˵�Ʊ��,�޷��������������');
    end
    else
    begin

    end;
  end;

//  if getParametervalue('8006', Sysinfo.LoginUserInfo.OrgID) = '1' then
//  begin
//    if not checkBillno('PackSgBill') then
//    begin
//      SysDialogs.ShowInfo('δ���а�ǩ����Ʊ��,����ʱ�޷�ǩ����Σ�');
//    end;
//  end;

  refreshBill;

end;
procedure TFrmPackaccept.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(Key) = '{08E2D2A8-C225-437C-BC74-914E7E7D0351}' then
  begin
    tbtnSave.visible := aEnable; // ��ƱȨ��
  end;
  if GUIDToString(Key) = '{95A0F1EE-000D-48E3-8F55-93B422E5E2F9}' then
  begin
    ToolButton50.visible := aEnable; // ����Ȩ��
  end;
end;

procedure TFrmPackaccept.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // inherited;
  if (Key = VK_F1) then
  begin
    tbtnFilterClick(Sender);
  end
  else if (Key = VK_F2) then
  begin
    tbtnInsertClick(Sender);
  end
  else if (Key = VK_F3) then
  begin
    tbtnEditClick(Sender);
  end
  else if (Key = VK_F4) then
  begin
    tbtnDeleteClick(Sender);
  end
  else if (Key = VK_F5) then
  begin
    ToolButton50Click(Sender);
  end
  else if (Key = VK_F6) then
  begin
    tbtnCancelClick(Sender);
  end;
  Key := 0;
end;

procedure TFrmPackaccept.FormShow(Sender: TObject);
begin
  inherited;

  jcdspackedvalue.Active := True;
  jcdcertificatetypevalue.Active := True;
  jcdshiptypevalue.Active := True;
  jcdspaymethodvalue.Active := True;
  jcdsstatusvalue.Active := True;
  jcdsgoodtypevalue.Active := True;
  jcdspacktypevalue.Active := True;
  jcdscollectstatusname.Active := True;
  jcdsrecyclestatusname.Active := True;
  nvcbborg.Active := True;
  nvcbbpackstatus.Active := True;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  // tmGetCurInvoinNo.Enabled := True;
end;



procedure TFrmPackaccept.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackaccept.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  isoriginalprint := True; // ��ԭƱ���ش�
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  // if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  // begin
  if not SysDialogs.Confirm('��ʾ', 'ȷ��Ҫ�ش����Ϣ��') then
  begin
    exit;
  end;
  { if jcdsResult.FieldByName('status').AsString = '1' then
    begin
    SysDialogs.ShowInfo('���а���ǩ���������ش�');
    exit;
    end;
    }
  if jcdsResult.FieldByName('status').AsString = '3' then
  begin
    SysDialogs.ShowInfo('���а��ѷ���,�����ش�');
    exit;
  end;

  if jcdsResult.FieldByName('status').AsString = '7' then
  begin
    SysDialogs.ShowInfo('���а�����Ʊ,�����ش�');
    exit;
  end;

  if (Sysinfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby')
      .AsInteger) or
    (Sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger)
    then
  begin
    SysDialogs.ShowMessage('�������ش����˿���������');
    exit;
  end;
  try
    printpack;
  finally
    tbtnFilter.Click;
    jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
  end;

end;

procedure TFrmPackaccept.tbtnDeleteClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  isoriginalprint := False; // ����ԭƱ���ش�
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  // if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  // begin
  if not SysDialogs.Confirm('��ʾ', 'ȷ��Ҫ�ش����Ϣ��') then
  begin
    exit;
  end;
  { if jcdsResult.FieldByName('status').AsString = '1' then
    begin
    SysDialogs.ShowInfo('���а���ǩ���������ش�');
    exit;
    end;
    }
  if jcdsResult.FieldByName('status').AsString = '3' then
  begin
    SysDialogs.ShowInfo('���а��ѷ���,�����ش�');
    exit;
  end;

  if jcdsResult.FieldByName('status').AsString = '7' then
  begin
    SysDialogs.ShowInfo('���а�����Ʊ,�����ش�');
    exit;
  end;

  if (Sysinfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby')
      .AsInteger) or
    (Sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger)
    then
  begin
    SysDialogs.ShowMessage('�������ش����˿���������');
    exit;
  end;
  try
    printpack;
  finally
    tbtnFilter.Click;
    jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
  end;

  // end
  // else
  // begin
  // SysDialogs.ShowInfo('����ѡ����Ҫ�ش�ļ�¼��');
  // end;
end;

procedure TFrmPackaccept.tbtnEditClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  if jcdsResult.FieldByName('status').AsString = '1' then
  begin
    SysDialogs.ShowInfo('���а���ǩ���������޸ģ�');
    exit;
  end;

  if jcdsResult.FieldByName('status').AsString = '3' then
  begin
    SysDialogs.ShowInfo('���а��ѷ���,�����޸ģ�');
    exit;
  end;
   if jcdsResult.FieldByName('status').AsString = '5' then
  begin
    SysDialogs.ShowInfo('���а�����Ʊ,�����޸ģ�');
    exit;
  end;

  if (Sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger)
    then
  begin
    SysDialogs.ShowInfo('ֻ�ܶԱ��������а������޸Ĳ�����');
    exit;
  end;

  { if (SysInfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby').AsInteger)
    or (SysInfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger) then
    begin
    SysDialogs.ShowMessage('�������޸����˿���������');
    exit;
    end; }

  FrmPackacceptAdd := TFrmPackacceptAdd.Create(self, self.functionItem);
  try
    with FrmPackacceptAdd do
    begin
      Caption := '�а��޸�';
      packinfo.Enabled := True;
      dtpdepartdate.Enabled := False;
      nvcbbgoodname.Enabled := False;
      nvcbbpacked.Enabled := False;
      nvedtpacked.Enabled := False;
      nvedtpieces.Enabled := False;
      nvedtweight.Enabled := False;
      rbvaluablesno.Enabled := False;
      rbvaluablesyes.Enabled := False;
      nvcbbpaymethod.Enabled := False;
      nvcbbshiptype.Enabled := False;
      memremarks.Enabled := False;
      feeinfo.Enabled := False;
      edittype := Tedittype.update;
      nvhelptostation.id := self.jcdsResult.FieldByName('tostationid')
        .AsInteger;
      nvhelptostation.Text := self.jcdsResult.FieldByName('tostationname')
        .AsString;
      nvcbbgoodname.Text := self.jcdsResult.FieldByName('name').AsString;
      // �а�����
      nvcbbgoodname.SetItemIndexByValue(self.jcdsResult.FieldByName('name')
          .AsString);
      // nvcbbgoodname.SetItemIndexByCode(self.jcdsResult.FieldByName('goodtype')
      // .AsString);
      dtpdepartdate.DateTime := self.jcdsResult.FieldByName('departdate')
        .AsDateTime;
      // nvhelpschedule.id := self.jcdsResult.FieldByName('scheduleid').AsInteger;
      // nvhelpschedule.Text := self.jcdsResult.FieldByName('schedulecode')
      // .AsString;
      /// nvhelpvehiclecode.id := self.jcdsResult.FieldByName('vehicleid')
      // .AsInteger;
      // nvhelpvehiclecode.Text := self.jcdsResult.FieldByName('vehiclecode')
      // .AsString;
      nvcbbpacked.SetItemIndexByCode(self.jcdsResult.FieldByName('packed')
          .AsString);
      nvedtpieces.Text := self.jcdsResult.FieldByName('pieces').AsString;
      nvedtweight.Text := self.jcdsResult.FieldByName('weight').AsString;
      // nvedtvolume.Text := self.jcdsResult.FieldByName('volume').AsString;
      if self.jcdsResult.FieldByName('valuables').AsBoolean then
      begin
        rbvaluablesno.Checked := False;
        rbvaluablesyes.Checked := True;
      end
      else
      begin
        rbvaluablesno.Checked := True;
        rbvaluablesyes.Checked := False;
      end;
      memremarks.Text := self.jcdsResult.FieldByName('remak').AsString;
      nvedtsender.Text := self.jcdsResult.FieldByName('sender').AsString;
      nvedtsenderphone.Text := self.jcdsResult.FieldByName('senderphone')
        .AsString;
      nvedtsenderaddress.Text := self.jcdsResult.FieldByName('senderaddress')
        .AsString;
      nvedtconsignee.Text := self.jcdsResult.FieldByName('consignee').AsString;
      nvedtconsigneephone.Text := self.jcdsResult.FieldByName('consigneephone')
        .AsString;
      nvedtconsigneeaddress.Text := self.jcdsResult.FieldByName
        ('consigneeaddress').AsString;
      nvcbbcertificatetype.SetItemIndexByCode
        (self.jcdsResult.FieldByName('certificatetype').AsString);
      nvedtcertificateno.Text := self.jcdsResult.FieldByName('certificateno')
        .AsString;
      nvcbbshiptype.SetItemIndexByCode(self.jcdsResult.FieldByName('shiptype')
          .AsString);
      nvcbbpaymethod.SetItemIndexByCode(self.jcdsResult.FieldByName('paymethod')
          .AsString);
      nvedtshipprice.Text := self.jcdsResult.FieldByName('shipprice').AsString;
      nvedtinsuredamount.Text := self.jcdsResult.FieldByName('insuredamount')
        .AsString;
      // nvedtinsurance.Text := self.jcdsResult.FieldByName('insurance').AsString;
      nvedthandfee.Text := self.jcdsResult.FieldByName('handfee').AsString;
      nvedtpackfee.Text := self.jcdsResult.FieldByName('packfee').AsString;
      nvedtinsurancefee.Text := self.jcdsResult.FieldByName('insurancefee')
        .AsString;
      nvedttransitfee.Text := self.jcdsResult.FieldByName('transitfee')
        .AsString;
      nvedtdeliveryfee.Text := self.jcdsResult.FieldByName('deliveryfee')
        .AsString;
      nvedtotherfee.Text := self.jcdsResult.FieldByName('otherfee').AsString;
      nvedttotalfee.Text := self.jcdsResult.FieldByName('totalfee').AsString;
      nvedtpackprice.Text := self.jcdsResult.FieldByName('packprice').AsString;
      { if (self.jcdsResult.FieldByName('clientid').AsInteger <= 0) or
        (self.jcdsResult.FieldByName('clientname').AsString = '') then
        begin
        rbnoclient.Checked := True;
        rbyesclient.Checked := False;
        end
        else
        begin
        rbnoclient.Checked := False;
        rbyesclient.Checked := True; }
      if self.jcdsResult.FieldByName('clientid').AsString <> '' then
      begin
        nvhelpclient.id := self.jcdsResult.FieldByName('clientid').AsInteger;
        nvedtsendtype.ItemIndex := self.jcdsResult.FieldByName('clienttype')
          .AsInteger;
      end
      else
      begin
        // nvhelpclient.id := self.jcdsResult.FieldByName('clientid').AsInteger;
        nvedtsendtype.ItemIndex := -1;
      end;
      nvhelpclient.Text := self.jcdsResult.FieldByName('clientcode').AsString;
      nvedtsendintegrater.Text := self.jcdsResult.FieldByName
        ('clientintegrater').AsString;
      nvedtIntegrateMoney.Text := self.jcdsResult.FieldByName('integraterprice')
        .AsString;
      nvedtservicefee.Text := self.jcdsResult.FieldByName('servicefee')
        .AsString;
      nvedtsenderphone.Text := self.jcdsResult.FieldByName('senderphone')
        .AsString;
      nvedtsenderaddress.Text := self.jcdsResult.FieldByName('senderaddress')
        .AsString;
      nvedtsender.Text := self.jcdsResult.FieldByName('sender').AsString;
      // end;
      nvedtpackno.Text := self.jcdsResult.FieldByName('packno').AsString;
      nvedtpackno.Enabled := False;
      packno := self.jcdsResult.FieldByName('packno').AsString;
      invoiceno := self.jcdsResult.FieldByName('invoiceno').AsString;
      onlycode := self.jcdsResult.FieldByName('onlycode').AsString;
      synccode := self.jcdsResult.FieldByName('synccode').AsString;
      sellby := self.jcdsResult.FieldByName('sellby').AsInteger;
      sellbyname := self.jcdsResult.FieldByName('sellbyname').AsString;
      packid := self.jcdsResult.FieldByName('id').AsInteger;
      createtime := self.jcdsResult.FieldByName('createtime').AsDateTime;
      createby := self.jcdsResult.FieldByName('createby').AsInteger;
      OrgID := self.jcdsResult.FieldByName('orgid').AsInteger;
      orgname := self.jcdsResult.FieldByName('orgname').AsString;

    end;
    if SysMainForm.showFormModal(FrmPackacceptAdd, False) = mrOk then
    begin
      id := FrmPackacceptAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id', id, []);
    end;
  finally
    FreeAndNil(FrmPackacceptAdd);
    refreshBill;
  end;
  // end
  // else
  // begin
  // SysDialogs.ShowInfo('����ѡ����Ҫ�޸ĵļ�¼��');
  // end;
end;

procedure TFrmPackaccept.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdspackedvalue.Active := False;
  jcdspackedvalue.Active := True;
  // nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;

    Params.ParamValues['filter_INS_p!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_p!createtime'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!createtime'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime + 1);

    Params.ParamValues['filter_LIKES_p!sender_OR_p!consignee'] := Trim
      (nvedtnames.Text);

    Params.ParamValues['filter_EQS_p!packtype'] := '0';
    if nvhelptostation.id > 0 then
      Params.ParamValues['filter_EQL_p!tostationid'] := nvhelptostation.id
    else
      Params.ParamValues['filter_EQL_p!tostationid'] := '';
    if Trim(NovaEdtNum.Text) <> '' then
      Params.ParamValues['filter_EQS_p!packno'] := Trim(NovaEdtNum.Text)
    else
      Params.ParamValues['filter_EQS_p!packno'] := null;
    if nvcbbpackstatus.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_p!status'] := ''
    else
      Params.ParamValues['filter_EQS_p!status'] :=
        nvcbbpackstatus.GetSelectCode;

    if (nvcbbpackrecycletstatus.GetSelectID > -1) then // ������״̬
      Params.ParamValues['filter_EQL_p!recyclestatus'] :=
        nvcbbpackrecycletstatus.GetSelectCode;
    if (nvcbbcollectstatus.GetSelectID > 0) then // �Ƿ����
      Params.ParamValues['filter_EQL_p!paymethod'] :=
        nvcbbcollectstatus.GetSelectCode
    else
      Params.ParamValues['filter_EQL_p!paymethod'] := null;

    // jcdsResult.AfterScroll := nil;

    Active := True;
    NovaEdtNum.SetFocus;
  end;
end;

procedure TFrmPackaccept.tbtnInsertClick(Sender: TObject);
var
  curid: Integer;
begin
  inherited;
  if (isdrawbill = '1') then
  begin
    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
      (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then
    begin

    end
    else
    begin

      if (ispackbill = True) and
        (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] = 0) then
      begin
        if (initBillNo('PackBill')) then
        begin
          if (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] = 0) then
          begin
            SysDialogs.Warning('����ǰ�����˵��������꣬��������ȡ��Ʊ��');
            exit;
            // /// /          result := false;
          end
          else
            refreshBill();
          // /// /          result := true;

        end;
      end
      else
      begin
        if not checkBillno('PackBill') then
        begin
          SysDialogs.ShowInfo('δ���а����˵�Ʊ��,�޷��������������');

          exit;
        end
        else
        begin
          refreshBill();

        end;
      end;
    end;

  end;
  refreshBill();
  { if getParametervalue('8006', Sysinfo.LoginUserInfo.OrgID) = '1' then
    begin
    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackSgBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackSgBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] > 0) then
    begin

    end
    else
    begin
    if (ispacksgbill = True) and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] = 0) then
    begin
    if (initBillNo('PackSgBill')) then
    begin
    if (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] = 0) then
    begin
    SysDialogs.Warning('����ǰ�ĵ��������꣬��������ȡ��Ʊ��');
    // result := false;
    end
    else
    refreshBill();
    // result := true;

    end;
    end
    else
    begin
    if not checkBillno('PackSgBill') then
    begin
    SysDialogs.ShowInfo('δ���а�ǩ����Ʊ��,����ʱ�޷�ǩ����Σ�');
    end
    else
    begin
    refreshBill();
    end;
    end;
    end;
    end; }

  { SysDialogs.ShowMessage(inttostr(strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill'])+ 1));
    SysDialogs.ShowMessage(boolToStr(Sysinfo.LoginUserInfo.curBillNo.ContainsKey
    ('PackSgBill'))); // 0
    //  SysDialogs.ShowMessage(Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill']);
    // ��ʼ��
    SysDialogs.ShowMessage(inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
    ['PackSgBill'])); // ��ȡ�� }

  FrmPackacceptAdd := TFrmPackacceptAdd.Create(self);
  try
    with FrmPackacceptAdd do
    begin
      flag := True;
      Caption := '�а�����';

      if SysMainForm.showFormModal(FrmPackacceptAdd, False) = mrOk then
      begin
        curid := FrmPackacceptAdd.operationid;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmPackacceptAdd);
    refreshBill;

  end;

end;

procedure TFrmPackaccept.tbtnpaymentrecycleClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('status').AsString = '3' then
  begin
    SysDialogs.ShowInfo('���а��ѷ���,���ܻ��գ�');
    exit;
  end;

  if jcdsResult.FieldByName('status').AsString = '5' then
  begin
    SysDialogs.ShowInfo('���а�����Ʊ,���ܻ��գ�');
    exit;
  end;

  try
    if (jcdsResult.FieldByName('paymethod').AsString <> '1') then
    begin
      SysDialogs.ShowInfo('û�д���,�������Ը�����ղ�����');
      exit;
    end
    else
    begin
      if jcdsResult.FieldByName('recyclestatus').AsString = '1' then
      begin
        SysDialogs.ShowInfo('�Ը����ѻ���,���������Ը�����ղ�����');
        exit;
      end
      else
      begin
        // SysDialogs.ShowInfo('��Ҫ�տ');
        if not SysDialogs.Confirm('��ʾ', 'ȷ�����жԸ�����ղ�����') then
        begin
          exit;
        end;
        with jcdspaymentrecyclesave do
        begin

          Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id')
            .AsString;
          Execute;

          if Params.ParamValues['msg'] <> '' then
          begin
            SysDialogs.ShowMessage(Params.ParamValues['msg']);
          end;
          if Params.ParamValues['flag'] = 1 then
          begin
            log := '�Ը�����գ�' + VarToStr(Params.ParamValues['packid']);
            SysLog.WriteLog('�а�����->�а�����', '�Ը������', log);
          end;
        end;

      end;
    end;
  finally
    // FreeAndNil(jcdsResult);
    tbtnFilterClick(Sender);
  end;

end;

procedure TFrmPackaccept.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  if jcdsResult.FieldByName('status').AsString <> '0' then
  begin
    SysDialogs.ShowInfo('ֻ�ܶԿ��״̬���а�������Ʊ������');
    exit;
  end;

  if (Sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger)
    then
  begin
    SysDialogs.ShowInfo('ֻ�ܶԱ��������а�������Ʊ������');
    exit;
  end;
  FrmPackreturnback := TFrmPackreturnback.Create(self);
  try
    with FrmPackreturnback do
    begin
      packid := self.jcdsResult.FieldByName('id').AsInteger;
      dtpdepartdate.DateTime := self.jcdsResult.FieldByName('createtime')
        .AsDateTime;
      nvedtaccepter.Text := self.jcdsResult.FieldByName('sender').AsString;
      nvedtpackno.Text := self.jcdsResult.FieldByName('packno').AsString;
      nvhelptostation.Text := self.jcdsResult.FieldByName('tostationname')
        .AsString;
      nvedttotalfee.Text := self.jcdsResult.FieldByName('totalfee').AsString;
      if SysMainForm.showFormModal(FrmPackreturnback, False) = mrOk then
      begin
        tbtnFilter.Click;
      end;
    end;
  finally
    FreeAndNil(FrmPackreturnback);
  end;
end;

procedure TFrmPackaccept.printpack();
begin
  FrmPackacceptReport := TFrmPackacceptReport.Create(self);
  with FrmPackacceptReport do
  begin

    goodtype := jcdsResult.FieldByName('goodtypevalue').AsString; // �������
    sendstationvalue := jcdsResult.FieldByName('sendstationname').AsString;
    // ����վ
    tostationvalue := jcdsResult.FieldByName('tostationname').AsString;
    // Ŀ�ĵ�
    name := jcdsResult.FieldByName('name').AsString; // ��������
    schedulevalue := jcdsResult.FieldByName('schedulecode').AsString; // ���
    vehiclevalue := jcdsResult.FieldByName('vehiclecode').AsString; // ���ƺ�
    departdate := jcdsResult.FieldByName('departdate').AsString; // ��������������

    if isdrawbill = '1' then // ��ӡ���˵�
    begin
      if isoriginalprint then
        packno := jcdsResult.FieldByName('packno').AsString // ��Ʊ��
      else
        packno := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill']; // ԭƱ��
    end;

    // jcdsResult.FieldByName('packno').AsString; // �а�����
    invoiceno := ''; // ��Ʊ��
    sellbyname := jcdsResult.FieldByName('sellbyname').AsString; // ����Ա
    selltime := FormatDateTime('yyyy-MM-dd HH:mm:ss',
      jcdsResult.FieldByName('createtime').AsDateTime); // ����ʱ��
    pieces := jcdsResult.FieldByName('pieces').AsString; // ����;
    weight := jcdsResult.FieldByName('weight').AsString; // ����
    volume := jcdsResult.FieldByName('volume').AsString; // ���
    packaed := jcdsResult.FieldByName('packedvalue').AsString; // ��װ
    shippricemoney := jcdsResult.FieldByName('shipprice').AsString; // ���˷�
    packfeemoney := jcdsResult.FieldByName('packfee').AsString; // ��װ��
    handfeemoney := jcdsResult.FieldByName('handfee').AsString; // װж��
    deliveryfeemoney := jcdsResult.FieldByName('deliveryfee').AsString;
    // �ͻ���
    custodialmoney := jcdsResult.FieldByName('custodial').AsString; // ���ܷ�
    transitfeemoney := jcdsResult.FieldByName('transitfee').AsString;
    // ��ת��;
    insuredamountmoney := jcdsResult.FieldByName('insuredamount').AsString;
    // ���۽��
    insurancefeemoney := jcdsResult.FieldByName('insurancefee').AsString;
    // ���۷�
    insurancemoney := jcdsResult.FieldByName('insurance').AsString; // ���շ�
    otherfeemoney := jcdsResult.FieldByName('otherfee').AsString; // ��������

    servicefeemoney := jcdsResult.FieldByName('servicefee').AsString; // �����
    integraterprice := jcdsResult.FieldByName('integraterprice').AsString;
    // ����֧�����
    totalprice := FloatToStr(jcdsResult.FieldByName('totalfee')
        .AsFloat + jcdsResult.FieldByName('packprice').AsFloat); // ʵ��֧�����

    totalfeemoney := jcdsResult.FieldByName('totalfee').AsString; // �ϼƽ��
    // location:string;//varchar2(20)	y			���λ��
    packpricemoney := jcdsResult.FieldByName('packprice').AsString; // ���ջ���
    Sender := jcdsResult.FieldByName('sender').AsString; // ������
    senderphone := jcdsResult.FieldByName('senderphone').AsString; // �����˵绰
    senderaddress := jcdsResult.FieldByName('senderaddress').AsString;
    // �����˵�ַ
    consignee := jcdsResult.FieldByName('consignee').AsString; // �ջ���
    consigneephone := jcdsResult.FieldByName('consigneephone').AsString;
    // �ջ��˵绰
    consigneeaddress := jcdsResult.FieldByName('consigneeaddress').AsString;
    // �ջ��˵�ַ
    certificatetype := jcdsResult.FieldByName('certificatetypevalue').AsString;
    // ֤������
    certificateno := jcdsResult.FieldByName('certificateno').AsString;
    // ֤������
    shiptype := jcdsResult.FieldByName('shiptypevalue').AsString; // ���˷�ʽ
    paymethod := jcdsResult.FieldByName('paymethodvalue').AsString; // ���ʽ
    departtime := jcdsResult.FieldByName('departtime').AsString; // ����ʱ��
    // �Ƿ������Ʒ
    if jcdsResult.FieldByName('valuables').AsBoolean then
      valuables := '��'
    else
      valuables := '��';
    remarks := jcdsResult.FieldByName('remak').AsString; // ;//��������

    // with jcdswhackpack do
    // begin
    // if isdrawbill = '1' then
    // begin
    // Active := False;
    // Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
    // Params.ParamValues['pack.sellby'] := jcdsResult.FieldByName('sellby')
    // .AsString;
    // if isoriginalprint then
    // begin
    // packno := jcdsResult.FieldByName('packno').AsString;//ԭƱ���ش�,���޸�ԭƱ��״̬Ϊ����
    // Params.ParamValues['pack.packno'] := packno;
    // end
    // else
    // begin
    // Params.ParamValues['pack.packno'] := packno;
    // end;
    // Execute;

    if not isoriginalprint then
    begin
      with jcdswhackpack do
      begin
        if isdrawbill = '1' then
        begin
          Active := False;
          Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id')
            .AsString;
          Params.ParamValues['pack.sellby'] := jcdsResult.FieldByName('sellby')
            .AsString;
          Params.ParamValues['pack.packno'] := packno;
          Execute;

          if Params.ParamValues['msg'] <> '' then
          begin
            SysDialogs.ShowMessage(Params.ParamValues['msg']);
          end;
          if Params.ParamValues['flag'] = 1 then
          begin
            try
              PrintPackReport;
            finally
              updatepackbill();
              refreshBill();
            end;
          end;
        end
        else
        begin
          try
            PrintPackReport;
          finally
            refreshBill();
          end;
        end;
      end;
    end
    else
    begin
      try
        PrintPackReport;
      finally
        // updatepackbill();
        refreshBill();
      end;
    end;
  end;
  FreeAndNil(FrmPackacceptReport);
  // ModalResult := mrOk;
  // FrmPackacceptReport.Close;
end;

procedure TFrmPackaccept.updatepackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with Sysinfo.LoginUserInfo do
  begin
    billinusenextform := IntToStr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackBill']));
    billinusenextno := IntToStr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackBill']) + 1);

    curBillNo.AddOrSetValue('PackBill', zerofill(billinusenextno,
        length(curBillNo.Items['PackBill'])));
    curBillNum.AddOrSetValue('PackBill', curBillNum.Items['PackBill'] - 1);

    if curBillNum.Items['PackBill'] > 0 then
      billinusestatus := '1'
    else
      billinusestatus := '2';

  end;

  with jcdsupdateBillinuse do
  begin
    Active := False;
    Params.ParamValues['billinusestatus'] := billinusestatus;
    Params.ParamValues['billinusenextno'] := billinusenextno;
    Params.ParamValues['billinusenextform'] := billinusenextform;
    Params.ParamValues['billtypecode'] := 'PackBill';

    Execute;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;

    if Params.ParamValues['flag'] = -1 then
    begin

    end;

  end;
end;

procedure TFrmPackaccept.tmGetCurInvoinNoTimer(Sender: TObject);
begin
  inherited;
  refreshBill;
end;

procedure TFrmPackaccept.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ���Ϣ������') then
    begin
      exit;
    end;

    with jcdspackwaste do
    begin

      Active := False;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('���а���ǩ�����޷�������');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('���а������죬�޷�������');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '3' then
      begin
        SysDialogs.ShowInfo('���а��ѷ���,�޷��ٴη�����');
        exit;
      end;

      Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['pack.status'] := '3';

      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        tbtnFilter.Click;
      end;
    end;
    // jcdsResult.Delete;
    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ���ϵļ�¼��');
  end;
end;

end.
