unit UFrmPackWarehousing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NovaCheckedComboBox, NvDbgridEh, NovaHComboBox, NvPrnDbgeh, NovaPrint, StrUtils,
  Generics.Collections;

type
  TFrmPackWarehousing = class(TSimpleCRUDForm)

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
    Label1: TLabel;
    jcdsResultischoose: TBooleanField;
    jcdspacktypevalue: TjsonClientDataSet;
    jcdsResultpacktypevalue: TWideStringField;
    jcdspackwaste: TjsonClientDataSet;
    jcdsResultunloadfee: TFloatField;
    jcdsResultweight: TFloatField;
    Label3: TLabel;
    nvedtpackno: TNovaEdit;
    jcdsPackup: TjsonClientDataSet;
    inwarehousemsg: TLabel;
    GroupBox2: TGroupBox;
    lbpackbill: TLabel;
    Label5: TLabel;
    lbbillnum: TLabel;
    jcdsResultzhuanyuntostationid: TLargeintField;
    jcdsResultzhuanyuntostationname: TWideStringField;
    jcdslocationvalue: TjsonClientDataSet;
    jcdsResultlocationvalue: TWideStringField;
    Label4: TLabel;
    nvcbbgoodsstatus: TNovaComboBox;
    nvcbbsellby: TNovaCheckedComboBox;
    jcdsResultpackarriverno: TWideStringField;
    jcdsResultpackarriverstatus: TWideStringField;
    jcdsResultpackarriverdate: TDateTimeField;
    jcdspackarriverstatus: TjsonClientDataSet;
    jcdsResultpackarriverstatusname: TWideStringField;
    jcdsResultgoodsstatus: TWideStringField;
    jcdsResultservicefee: TFloatField;
    jcdspaymentrecyclesave: TjsonClientDataSet;
    jcdsResultrecyclestatus: TWideStringField;
    jcdsResultpackarriverid: TLargeintField;
    jcdswhackpackarriver: TjsonClientDataSet;
    jcdsupdateBillinuse: TjsonClientDataSet;
    jcdsgoodsstatus: TjsonClientDataSet;
    jcdsResultgoodsstatusname: TWideStringField;
    jcdsResultpackarrivercreatby: TLargeintField;
    jcdsResultpackarrivercreatetime: TDateTimeField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure nvedtpacknoKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtpacknoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButton50Click(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);

  private
    { Private declarations }
    id: Integer;
    ispackbill: Boolean; // �ж�ǰ���Ƿ���ȡ��Ʊ�����ж����������Ʊ��
    ispackarrivalbill: string; // �Ƿ���ȡ�а�������������
    // packarriverno : String; //�а���������
    isoriginalprint: Boolean; // ��ԭƱ���ش�
    packprint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
    procedure refreshBill;
    procedure packnoUpStatus;
    procedure updatepackarrivalbill;
  public
    { Public declarations }
    billinuseid: Integer;
    billinusestartno, billinusenextno, billinuseendno: Integer;
  end;

var
  FrmPackWarehousing: TFrmPackWarehousing;

implementation

uses UFrmPackWarehousingAdd;
{$R *.dfm}

procedure TFrmPackWarehousing.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackWarehousing.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbbgoodsstatus.Active := True;

  with nvcbbsellby do
  begin
    nvcbbsellby.Active := False;
    Params.ParamValues['filter_INS_u!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_INS_r!id'] := '(2,38767)'; // �����Ȩ�޵Ľ�ɫ�������Ա ,����Ա
    nvcbbsellby.Active := True;
  end;

  // nvhlpseller.id := SysInfo.LoginUserInfo.UserID;
  // nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;
  GroupBox2.Visible := False;
  ispackarrivalbill := getParametervalue('8068', Sysinfo.LoginUserInfo.OrgID);
  if (ispackarrivalbill = '1') then
  begin
    GroupBox2.Visible := True;
    if not checkBillno('PackArrivalBill') then
    begin
      SysDialogs.ShowInfo('δ���а�����������Ʊ��,�޷�������������');
    end
    else
    begin

    end;
  end;

  refreshBill;

end;

procedure TFrmPackWarehousing.FormKeyUp(Sender: TObject; var Key: Word;
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
  end;
  Key := 0;

end;

procedure TFrmPackWarehousing.FormShow(Sender: TObject);
begin
  inherited;

  jcdspackedvalue.Active := True;
  jcdslocationvalue.Active := True;
  jcdcertificatetypevalue.Active := True;
  jcdshiptypevalue.Active := True;
  jcdspaymethodvalue.Active := True;
  jcdsstatusvalue.Active := True;
  jcdsgoodtypevalue.Active := True;
  jcdspacktypevalue.Active := True;

  nvcbborg.Active := True;

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then

  begin

  end
  else
  begin

  end;
  nvedtpackno.SetFocus;
end;

procedure TFrmPackWarehousing.nvedtpacknoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if trim(nvedtpackno.Text) = '' then
      exit;
    // if length(trim(NovaEdtTicketNo.text)) > Sysinfo.curBillLength.Items
    // ['PackBill'] then
    // begin
    //
    // // �����ȡ�ĳ�Ʊ���ȴ���ϵͳƱ�ݳ��ȣ���Ӻ����ȡ������ϵͳ��Ʊ�ݳ���
    // templen := length(trim(NovaEdtTicketNo.text))
    // - Sysinfo.curBillLength.Items['Ticket'];
    // NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, templen + 1,
    // length(NovaEdtTicketNo.text));
    // end;

    // ���ж�Ʊ�ų��ȣ�������Ȳ��ԣ���ʾ���ó�Ʊ�����ڣ�����˲���������
    // if length(trim(nvedtpackno.Text)) = SysInfo.curBillLength.Items['PackBill']
    // then
    // begin
    packnoUpStatus();
    nvedtpackno.Clear;
    nvedtpackno.SetFocus;
    // end
    // else
    // begin
    // // SysDialogs.Warning('��Ʊ�Ų����ڣ�');
    // inwarehousemsg.Caption := trim(nvedtpackno.Text) + 'Ʊ�Ų����ڣ�';
    // nvedtpackno.Clear;
    // nvedtpackno.SetFocus;
    // end;
  end;

end;

procedure TFrmPackWarehousing.nvedtpacknoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  nvedtpackno.SetFocus;
end;

procedure TFrmPackWarehousing.packnoUpStatus();
begin
  inherited;
  with jcdsPackup do
  begin
    Active := False;

    Params.ParamValues['pack.packno'] := trim(nvedtpackno.Text);
    Params.ParamValues['pack.status'] := '4';

    Execute;

    if Params.ParamValues['msg'] <> '' then
    begin
      // SysDialogs.ShowMessage(Params.ParamValues['msg']);
      inwarehousemsg.Caption := Params.ParamValues['msg'];
      SysLog.WriteLog('�а�����->�������', 'ɨ�����', Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      with jcdsResult do
      begin
        Active := False;
        Params.ParamValues['filter_EQS_p!packno'] := trim(nvedtpackno.Text);
        Active := True;
        nvedtpackno.Text := '';
      end;
    end;
  end;
end;

procedure TFrmPackWarehousing.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ��а�������') then
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
        SysDialogs.ShowInfo('���а��Ѵ����޷�������');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '3' then
      begin
        SysDialogs.ShowInfo('���а��ѷ���,�޷��ٴη�����');
        exit;
      end;

      if jcdsResult.FieldByName('createby').AsString = '0' then
      begin
        SysDialogs.ShowInfo('������������,�޷�������');
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

procedure TFrmPackWarehousing.tbtnEditClick(Sender: TObject);
var entrypackerList : TStringList;
var i : Integer;
begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('���а��Ѵ����޷��޸ģ�');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '3' then
    begin
      SysDialogs.ShowInfo('���а��ѷ���,�޷��޸ģ�');
      exit;
    end;

    if jcdsResult.FieldByName('createby').AsString = '0' then
    begin
      SysDialogs.ShowInfo('������������,�޷��޸ģ�');
      exit;
    end;

    FrmPackWarehousingAdd := TFrmPackWarehousingAdd.Create(self,
      self.functionItem);
    try
      with FrmPackWarehousingAdd do
      begin
        Caption := '�޸ĵ������';
        edittype := Tedittype.update;

        packarriverid := jcdsResult.FieldByName('packarriverid').AsInteger;
        id := packarriverid;
        packarrivercreateby := jcdsResult.FieldByName('packarrivercreatby').AsInteger;
        packarrivercreatetime := jcdsResult.FieldByName('packarrivercreatetime').AsString;
        nvedtpackarriverno.Text := jcdsResult.FieldByName('packarriverno')
          .AsString; // ��������
        nvedtpackno.Text := jcdsResult.FieldByName('packno').AsString; // �а�����
        // �а�����
        nveditpackname.Text := jcdsResult.FieldByName('name').AsString;
        // ����״̬
        nvcbbgoodsstatus.ItemIndex := jcdsResult.FieldByName('goodsstatus')
          .AsInteger;
        // ��ת��
        nvedttransitfee.Text := jcdsResult.FieldByName('transitfee').AsString;
        // �����
        nvedtservicefee.Text := jcdsResult.FieldByName('servicefee').AsString;
        // ����
        nvedtpackprice.Text := jcdsResult.FieldByName('packprice').AsString;
        // ������
        // nvcbbentrypacker.Text := jcdsResult.FieldByName('entrypacker').AsString;
        entrypackerList := TStringList.Create;
        entrypackerList.DelimitedText := jcdsResult.FieldByName('entrypacker').AsString;
        entrypackerList.Delimiter := ';';
        for i := 0 to (entrypackerList.Count -2) do
         begin
            nvcbbentrypacker.SetCheck(nvcbbentrypacker.Items.indexOf(StrUtils.LeftStr(entrypackerList[i],length(entrypackerList[i])-1)),true);
         end;
         nvcbbentrypacker.SetCheck(nvcbbentrypacker.Items.indexOf(entrypackerList[entrypackerList.Count-1]),true);
        // ���ʽ
        nvcbbpaymethod.ItemIndex := StrToInt
          (jcdsResult.FieldByName('paymethod').AsString);

        // goodtype := jcdsResult.FieldByName('goodtypevalue').AsString; // �������
        packid := jcdsResult.FieldByName('id').AsInteger;
        createby := jcdsResult.FieldByName('createby').AsInteger;
        createtime := jcdsResult.FieldByName('createtime').AsDateTime;
        nvhelpsendstationid.id := jcdsResult.FieldByName('sendstationid')
          .AsInteger; // ����վ
        nvhelpsendstationid.Text := jcdsResult.FieldByName('sendstationname')
          .AsString;

        // tostationid := jcdsResult.FieldByName('tostationname').AsInteger; // Ŀ�ĵ�
        // nvedtname.Text := jcdsResult.FieldByName('name').AsString; // ��������
        // scheduleid := jcdsResult.FieldByName('scheduleid').AsInteger; // ���
        nvhelpvehiclecode.id := jcdsResult.FieldByName('vehicleid').AsInteger;
        // ���ƺ�
        nvhelpvehiclecode.Text := jcdsResult.FieldByName('vehiclecode')
          .AsString;
        // depart := jcdsResult.FieldByName('departdate').AsDateTime; // ��������������
        nvedtpackno.Text := jcdsResult.FieldByName('packno').AsString; // �а�����
        nvedtpackno.Enabled := False;
        // invoiceno := ''; // ��Ʊ��
        // sellby := jcdsResult.FieldByName('sellby').AsInteger; // ����Ա
        nvedtpieces.Text := jcdsResult.FieldByName('pieces').AsString; // ����;
        // nvedtweight.Text := jcdsResult.FieldByName('weight').AsString; // ����
        // volume := jcdsResult.FieldByName('volume').AsString; // ���
        nvcbbpacked.SetItemIndexByCode
          (jcdsResult.FieldByName('packed').AsString); // ��װ
        nvedtshipprice.Text := jcdsResult.FieldByName('shipprice').AsString;
        // ���˷�
        // nvedtpackfee.Text := jcdsResult.FieldByName('packfee').AsString; // ��װ��
        // nvedthandfee.Text := jcdsResult.FieldByName('handfee').AsString;
        // ����װж��
        // nvedtunloadfee.Text := jcdsResult.FieldByName('unloadfee').AsString;
        // ����װж��

        // nvedtdeliveryfee.Text := jcdsResult.FieldByName('deliveryfee')
        // .AsString; // �ͻ���
        // custodial := jcdsResult.FieldByName('custodial').AsFloat; // ���ܷ�
        // nvedttransitfee.Text := jcdsResult.FieldByName('transitfee').AsString;
        // ��ת��;
        // nvedtinsuredamount.Text := jcdsResult.FieldByName('insuredamount')
        // .AsString; // ���۽��
        // nvedtinsurancefee.Text := jcdsResult.FieldByName('insurancefee')
        // .AsString; // ���۷�
        // nvedtinsurance.Text := jcdsResult.FieldByName('insurance').AsString;
        // ���շ�
        nvedtotherfee.Text := jcdsResult.FieldByName('otherfee').AsString;
        // ��������
        nvedttotalfee.Text := jcdsResult.FieldByName('totalfee').AsString;
        // �ϼƽ��
        // location:string;//varchar2(20)	y			���λ��
        nvedtpackprice.Text := jcdsResult.FieldByName('packprice').AsString;
        // ���ջ���
        // nvedtSender.Text := jcdsResult.FieldByName('sender').AsString; // ������
        // senderphone := jcdsResult.FieldByName('senderphone').AsString; // �����˵绰
        // senderaddress := jcdsResult.FieldByName('senderaddress').AsString; // �����˵�ַ
        nvedtconsignee.Text := jcdsResult.FieldByName('consignee').AsString;
        // �ջ���
        nvedtconsigneephone.Text := jcdsResult.FieldByName('consigneephone')
          .AsString; // �ջ��˵绰
        // �ջ��˵�ַ
        // nvedtconsigneeaddress.Text := jcdsResult.FieldByName('consigneeaddress')
        // .AsString;

        // certificatetype := jcdsResult.FieldByName('certificatetype').AsString;// ֤������

        // nvedtcertificateno.Text := jcdsResult.FieldByName('certificateno')
        // .AsString; // ֤������
        // shiptype := jcdsResult.FieldByName('shiptype').AsString; // ���˷�ʽ

        nvhelpzytostationid.id := jcdsResult.FieldByName('zhuanyuntostationid')
          .AsInteger;
        nvhelpzytostationid.Text := jcdsResult.FieldByName
          ('zhuanyuntostationname').AsString;
        // nvhlpseller.Id := jcdsResult.FieldByName('sellby')        //������
        // .AsInteger;
        // nvhlpseller.Text := jcdsResult.FieldByName('sellbyname')
        // .AsString;
        nvcbblocation.SetItemIndexByCode(jcdsResult.FieldByName('location')
            .AsString);
        // ��ע
      end;
      if SysMainForm.showFormModal(FrmPackWarehousingAdd, False) = mrok then
      begin
//        id := FrmPackWarehousingAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('packarriverid', inttostr(id), []);
      end;
    finally
      FreeAndNil(FrmPackWarehousingAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ�޸ĵļ�¼��');
  end;
end;

procedure TFrmPackWarehousing.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdspackedvalue.Active := False;
  jcdspackedvalue.Active := True;
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
    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);
    Params.ParamValues['filter_LIKES_p!packno'] := trim(nvedtpackno.Text);
    if (nvcbbsellby.GetSelectID = '') then // ������
      Params.ParamValues['filter_LIKES_p!entrypacker'] := ''
    else
      Params.ParamValues['filter_LIKES_p!entrypacker'] := nvcbbsellby.Text;
    Params.ParamValues['filter_EQS_p!packtype'] := '1'; // �а�����: 1����
    if (nvcbbgoodsstatus.GetSelectID > -1) then // ����״̬��0��ã�1����2��ʪ
      Params.ParamValues['filter_EQS_p!goodsstatus'] :=
        nvcbbgoodsstatus.GetSelectCode
    else
      Params.ParamValues['filter_EQS_p!goodsstatus'] := '';
    Active := True;
    nvedtpackno.SetFocus;
  end;
end;

procedure TFrmPackWarehousing.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;

  if (ispackarrivalbill = '1') then
  begin
    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackArrivalBill')
      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackArrivalBill')
      and (Sysinfo.LoginUserInfo.curBillNum.Items['PackArrivalBill'] > 0)
      then
    begin

    end
    else
    begin

      if (ispackbill = True) and (Sysinfo.LoginUserInfo.curBillNum.Items
          ['PackArrivalBill'] = 0) then
      begin
        if (initBillNo('PackArrivalBill')) then
        begin
          if (Sysinfo.LoginUserInfo.curBillNum.Items['PackArrivalBill'] = 0)
            then
          begin
            SysDialogs.Warning('����ǰ�ĵ����������������꣬��������ȡ��Ʊ��');
            exit;
          end
          else
            refreshBill();
        end;
      end
      else
      begin
        if not checkBillno('PackArrivalBill') then
        begin
          SysDialogs.ShowInfo('δ���а�����������Ʊ��,�޷�������������');

          exit;
        end
        else
        begin
          refreshBill();
        end;
      end;
    end;

  end;

  FrmPackWarehousingAdd := TFrmPackWarehousingAdd.Create(self);

  try
    FrmPackWarehousingAdd.Caption := '��ӵ������';
    FrmPackWarehousingAdd.edittype := Tedittype.add;
    FrmPackWarehousingAdd.packarriverno := Sysinfo.LoginUserInfo.curBillNo.Items
      ['PackArrivalBill']; // �а���������
      id := strtoint(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']) ;
    if SysMainForm.showFormModal(FrmPackWarehousingAdd, False) = mrok then
    begin
//      id := FrmPackWarehousingAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('packarriverno', id, []);
      nvedtpackno.SetFocus;
    end;
  finally
    FreeAndNil(FrmPackWarehousingAdd);
    refreshBill;
  end;
end;

procedure TFrmPackWarehousing.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  isoriginalprint := False; // �µ����ش�
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
  if jcdsResult.FieldByName('packarriverstatus').AsString = '1' then
  // �а��������״̬��0��δ���㣻1����ע����2���ѽ���
  begin
    SysDialogs.ShowInfo('���а���ע��,�����ش�');
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

    if not Assigned(packprint) then
      packprint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('����������', '����������'));
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;
    printValue.add('P_NO', Sysinfo.LoginUserInfo.curBillNo.Items
        ['PackArrivalBill']); // ��������
    id :=  strtoint(Sysinfo.LoginUserInfo.curBillNo.Items
        ['PackArrivalBill']);
    printValue.add('departdate', FormatDateTime('yyyy-mm-dd',
        jcdsResult.FieldByName('departdate').AsDateTime));
    printValue.add('sendstationvalue',
      jcdsResult.FieldByName('sendstationname').AsString);
    printValue.add('vehiclevalue',
      jcdsResult.FieldByName('vehiclecode').AsString);
    printValue.add('shippricemoney',
      jcdsResult.FieldByName('totalfee').AsString);   //  �����˷ѣ�ӦΪ�ϼƽ��
    printValue.add('packpricemoney',
      jcdsResult.FieldByName('packprice').AsString);   //  ���ջ���
    printValue.add('shiptostation',
      jcdsResult.FieldByName('zhuanyuntostationname').AsString);
    printValue.add('sellbyname',
      jcdsResult.FieldByName('entrypacker').AsString); // ������ֲ���Ա
    printValue.add('consignee', jcdsResult.FieldByName('consignee').AsString);
    printValue.add('consigneephone',
      jcdsResult.FieldByName('consigneephone').AsString);
    printValue.add('packed',
      jcdsResult.FieldByName('packedvalue').AsString);
    printValue.add('location',
      jcdsResult.FieldByName('locationvalue').AsString);
    printValue.add('totalprice', jcdsResult.FieldByName('totalfee').AsString);
    printValue.add('pieces', jcdsResult.FieldByName('pieces').AsString);
    packprint.SingleValue := printValue;

    with jcdswhackpackarriver do
    begin
      Active := False;
      Params.ParamValues['packarriver.id'] := jcdsResult.FieldByName
        ('packarriverid').AsString;
      Params.ParamValues['packarriver.packarriverno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill'];
      Params.ParamValues['packarriver.updateby'] := inttostr
        (Sysinfo.LoginUserInfo.UserID);
      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        try
          packprint.Print;
        finally
          updatepackarrivalbill();
          refreshBill();
        end;
      end;
    end;

  finally
    tbtnFilter.Click;
    jcdsResult.Locate('packarriverno', id, []);
//    jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
  end;
end;

procedure TFrmPackWarehousing.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

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
        end;

      end;
    end;
  finally
    // FreeAndNil(jcdsResult);
    tbtnFilterClick(Sender);
  end;

end;

procedure TFrmPackWarehousing.ToolButton51Click(Sender: TObject);
begin
  inherited;
  isoriginalprint := True; // ��ԭƱ���ش�
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if not SysDialogs.Confirm('��ʾ', 'ȷ��Ҫ�ش����Ϣ��') then
  begin
    exit;
  end;
  if jcdsResult.FieldByName('status').AsString = '3' then
  begin
    SysDialogs.ShowInfo('���а��ѷ���,�����ش�');
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

    if not Assigned(packprint) then
      packprint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('����������', '����������'));
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;
    printValue.add('P_NO', jcdsResult.FieldByName('packarriverno').AsString);
    // ��������
    printValue.add('departdate', FormatDateTime('yyyy-mm-dd',
        jcdsResult.FieldByName('departdate').AsDateTime));
    printValue.add('sendstationvalue',
      jcdsResult.FieldByName('sendstationname').AsString);
    printValue.add('vehiclevalue',
      jcdsResult.FieldByName('vehiclecode').AsString);
    printValue.add('shippricemoney',
      jcdsResult.FieldByName('totalfee').AsString);    // �����˷�
    printValue.add('packpricemoney',
      jcdsResult.FieldByName('packprice').AsString);   // ���ջ���
    printValue.add('shiptostation',
      jcdsResult.FieldByName('zhuanyuntostationname').AsString);
    printValue.add('sellbyname',
      jcdsResult.FieldByName('entrypacker').AsString); // ������ֲ���Ա
    printValue.add('consignee', jcdsResult.FieldByName('consignee').AsString);
    printValue.add('consigneephone',
      jcdsResult.FieldByName('consigneephone').AsString);
    printValue.add('packed',
      jcdsResult.FieldByName('packedvalue').AsString);
    printValue.add('location',
      jcdsResult.FieldByName('locationvalue').AsString);
    printValue.add('totalprice', jcdsResult.FieldByName('totalfee').AsString);
    printValue.add('pieces', jcdsResult.FieldByName('pieces').AsString);
    packprint.SingleValue := printValue;
    packprint.Print;

  finally
    tbtnFilter.Click;
    jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
  end;

end;

procedure TFrmPackWarehousing.refreshBill();
begin

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackArrivalBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackArrivalBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackArrivalBill'] > 0) then
  begin
    lbpackbill.Caption := Sysinfo.LoginUserInfo.curBillNo.Items
      ['PackArrivalBill'];
    lbbillnum.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['PackArrivalBill']);
    ispackbill := True;
  end
  else
  begin
    lbpackbill.Caption := '000000000000';
    lbbillnum.Caption := '0';
    ispackbill := False;
  end;

end;

procedure TFrmPackWarehousing.updatepackarrivalbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with Sysinfo.LoginUserInfo do
  begin
    billinusenextform := inttostr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']));
    billinusenextno := inttostr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']
        ) + 1);

    curBillNo.AddOrSetValue('PackArrivalBill', zerofill(billinusenextno,
        length(curBillNo.Items['PackArrivalBill'])));
    curBillNum.AddOrSetValue('PackArrivalBill',
      curBillNum.Items['PackArrivalBill'] - 1);

    if curBillNum.Items['PackArrivalBill'] > 0 then
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
    Params.ParamValues['billtypecode'] := 'PackArrivalBill';

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

end.
