unit UFrmPackacceptAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls, NovaPrint, Generics.Collections, Math;

type
  TFrmPackacceptAdd = class(TSimpleEditForm)
    jcdspacksave: TjsonClientDataSet;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    feeinfo: TGroupBox;
    Label17: TLabel;
    nvedtsender: TNovaEdit;
    Label18: TLabel;
    nvedtsenderphone: TNovaEdit;
    Label19: TLabel;
    nvedtsenderaddress: TNovaEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    nvedtconsignee: TNovaEdit;
    Label23: TLabel;
    Label24: TLabel;
    nvedtconsigneephone: TNovaEdit;
    Label25: TLabel;
    Label26: TLabel;
    nvedtconsigneeaddress: TNovaEdit;
    Label27: TLabel;
    nvedtcertificateno: TNovaEdit;
    Label33: TLabel;
    nvedtshipprice: TNovaEdit;
    Label34: TLabel;
    Label37: TLabel;
    nvedtpackfee: TNovaEdit;
    Label41: TLabel;
    nvedthandfee: TNovaEdit;
    Label43: TLabel;
    nvedttransitfee: TNovaEdit;
    Label44: TLabel;
    nvedtinsuredamount: TNovaEdit;
    Label45: TLabel;
    Label48: TLabel;
    nvedtdeliveryfee: TNovaEdit;
    Label49: TLabel;
    nvedtotherfee: TNovaEdit;
    Label51: TLabel;
    nvedttotalfee: TNovaEdit;
    Label52: TLabel;
    Label50: TLabel;
    nvedtinsurancefee: TNovaEdit;
    Label53: TLabel;
    Label54: TLabel;
    nvedtpackprice: TNovaEdit;
    Label35: TLabel;
    nvcbbcertificatetype: TNovaComboBox;
    jcdsquerypackfee: TjsonClientDataSet;
    wdstrngfldResultshowvalue: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    jcdsdistance: TjsonClientDataSet;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    jcdsupdateBillinuse: TjsonClientDataSet;
    packinfo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    nvcbbgoodname: TNovaComboBox;
    dtpdepartdate: TDateTimePicker;
    nvedtpieces: TNovaEdit;
    nvedtweight: TNovaEdit;
    memremarks: TMemo;
    nvcbbpacked: TNovaComboBox;
    rbvaluablesno: TRadioButton;
    rbvaluablesyes: TRadioButton;
    nvedtdistance: TNovaEdit;
    nvhelptostation: TNovaHelp;
    jcdsResult: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultischoose: TBooleanField;
    jcdsResultcode: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultstarttime: TDateTimeField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultisdeparted: TBooleanField;
    jcdsResultstatus: TWideStringField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultscheduleid: TLargeintField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultdrivername: TWideStringField;
    jcdsResultunitname: TWideStringField;
    Label29: TLabel;
    nvedtpackno: TNovaEdit;
    Label42: TLabel;
    lblunitid: TLabel;
    nvhelpclient: TNovaHelp;
    Label64: TLabel;
    nvedtservicefee: TNovaEdit;
    Label65: TLabel;
    Label68: TLabel;
    nvedtsendtype: TNovaComboBox;
    Label69: TLabel;
    nvedtsendintegrater: TNovaEdit;
    jcdsIntegrateToMoney: TjsonClientDataSet;
    nvedtPayMoney: TNovaEdit;
    Label67: TLabel;
    nvedtIntegrateMoney: TNovaEdit;
    nvedtintegrate: TNovaEdit;
    Label66: TLabel;
    jsdcQueryPercent: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    nvcbbshiptype: TNovaComboBox;
    nvcbbpaymethod: TNovaComboBox;
    lbl4: TLabel;
    jcdsParameters: TjsonClientDataSet;
    nvedtpacked: TNovaEdit;
    jcdspacktypesave: TjsonClientDataSet;
    Label3: TLabel;
    jcdsQueryRoutes: TjsonClientDataSet;
    NHelpSchedule: TNovaHComboBox;
    nvhelpschedule: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtweightChange(Sender: TObject);
    procedure nvhelptostationIdChange(Sender: TObject);
    procedure nvedtinsuredamountChange(Sender: TObject);
    procedure nvedtshippriceChange(Sender: TObject);
    procedure nvhelpscheduleClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nvhelpscheduleChange(Sender: TObject);
    procedure rbnoclientClick(Sender: TObject);
    procedure nvhelpclientIdChange(Sender: TObject);
    procedure nvedtpacknoKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtIntegrateChange(Sender: TObject);
    procedure nvedttotalfeeChange(Sender: TObject);
    procedure nvedtsendtypeChange(Sender: TObject);
    procedure nvedtweightExit(Sender: TObject);
    procedure nvedtPayMoneyExit(Sender: TObject);
    procedure nvedtsenderphoneKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nvedtconsigneephoneKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nvcbbpackedChange(Sender: TObject);
    procedure nvedtpackedExit(Sender: TObject);
    procedure dtpdepartdateChange(Sender: TObject);
    // procedure nvhelptostationKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    Foperationid: Integer;
    integrater: Integer;
    log, p8006: string;
    percent: double;
    schedulename, vehiclecodename: string;

    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
    multiplelists: TList < TDictionary < String, String >> ; // ������ݼ�
    multipleValueValue: TDictionary<String, String>;
    isdrawbill: string; // �Ƿ���Ҫ�������˵�Ʊ֤
    procedure shippricemoney;
    procedure totalfeemoney;
    procedure computePayMoney;
    procedure printpack;
    procedure updatepackbill;
    procedure packissue;
    procedure IssuePrintClink;
    procedure IssueUpdatePackbill;

  public
    { Public declarations }
    packid: Integer; // ;//number(10)	n
    packtype: string; // ;//varchar2(10)	y			�а����ͣ�0��������1������
    goodtype: string; // �������
    sendstationid: Integer; // number(10)	y			����վ
    tostationid: Integer; // number(10)	n			Ŀ�ĵ�
    name: string; // varchar2(50)	n			��������
    scheduleid: Integer; // number(10)	y			���
    vehicleid: Integer; // number(10)	n			���ƺ�
    depart: TDateTime; // date	;//date	y			��������������
    packno: string; // varchar2(20)	y			�а�����
    invoiceno: string; // varchar2(20)	y			��Ʊ��
    sellby: Integer; // number(10)	y			����Ա
    sellbyname: string;
    pieces: Integer; // number(3)	y			����
    weight: double; // number(3)	y			����
    volume: string; // varchar2(20)	y			���
    packaed: string; // varchar2(10)	y			��װ��ֽ�䡢���ϴ����ޣ�
    shipprice: double; // number(6,2)	y			���˷�
    packfee: double; // number(6,2)	y			��װ��
    handfee: double; // number(6,2)	y			װж��
    deliveryfee: double; // �ͻ���
    custodial: double; // number(6,2)	y			���ܷ�
    transitfee: double; // number(6,2)	y			��ת��
    insuredamount: double; // number(6,2)	y			���۽��
    insurancefee: double; // number(6,2)	y			���۷�
    insurance: double; // number(6,2)	y			���շ�
    otherfee: double; // number(6,2)	y			��������
    totalfee: double; // number(6,2)	y			�ϼƽ��
    location: string; // varchar2(20)	y			���λ��
    packprice: double; // number(6,2)	y			���ջ���
    Sender: string; // varchar2(30)	y			������
    senderphone: string; // varchar2(20)	y			�����˵绰
    senderaddress: string; // varchar2(100)	y			�����˵�ַ
    consignee: string; // varchar2(30)	y			�ջ���
    consigneephone: string; // varchar2(20)	y			�ջ��˵绰
    consigneeaddress: string; // varchar2(100)	y			�ջ��˵�ַ
    certificatetype: string; // varchar2(10)	y			֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
    certificateno: string; // varchar2(30)	y			֤������
    shiptype: string; // varchar2(10)	y			���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
    paymethod: string; // varchar2(10)	y			���ʽ���ָ����Ḷ��ȡ�����ֵ�
    valuables: string; // number(1)	y			�Ƿ������Ʒ
    status: string; // varchar2(10)	y			״̬(0����桢1��ǩ����2�����졢3������)
    packtturnoverid: string; // number(10)	y			�ɿ�id
    remak: string; // varchar2(50)	y			��ע
    orgid: Integer; // number(10)	y
    orgname: string;
    createtime: TDateTime; // date	n	sys;//date
    createby: Integer; // number(10)	n
    updatetime: TDateTime; // date	n	sys;//date
    updateby: Integer; // number(10)	n
    onlycode: string;
    synccode: string;
    clientid: Integer;
    clientText: string;
    insurancevalue, insurancefeevalue: double; // ���շѱ��۷ѱ���
    insuranceboolean, insurancefeeboolean: Integer; // ���շѱ��۷��Ƿ����Ʒ�
    isprintInvoice: string; // �а������Ƿ��ӡ��Ʊ  0����ӡ 1��ӡ
    departtime: string;
    distance: Integer; // ������
    flag: boolean; // �Ƿ����޸�
    isinputpacked: boolean; // ��װ����Ƿ�Ϊ����

    property operationid: Integer read Foperationid;
  end;

var
  FrmPackacceptAdd: TFrmPackacceptAdd;

implementation

uses PubFn, UFrmPackacceptReport, DateUtils;
{$R *.dfm}

procedure TFrmPackacceptAdd.bbtnSaveClick(Sender: TObject);

var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result: string;
  packstatus: string;

begin
  inherited;
  if nvedtpackno.Text = '' then
  begin
    SysDialogs.ShowMessage('���Ų���Ϊ��!');
    nvedtpackno.SetFocus;
    exit;
  end;

  if nvhelptostation.Id <= 0 then
  begin
    SysDialogs.ShowMessage('Ŀ�ĵز���Ϊ��!');
    nvhelptostation.SetFocus;
    exit;
  end;

  { if Trim(nvedtname.Text) = '' then
    begin
    SysDialogs.ShowMessage('�������Ʋ���Ϊ��!');
    nvedtname.SetFocus;
    exit;
    end; }

  if nvcbbgoodname.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ��������ƣ�');
    nvcbbgoodname.SetFocus;
    exit;
  end;

  if StrToInt(FormatDateTime('yyyyMMdd', dtpdepartdate.DateTime)) < StrToInt
    (FormatDateTime('yyyyMMdd', Now())) then
  begin
    SysDialogs.ShowMessage('�������ڲ���С�ڽ���!');
    dtpdepartdate.SetFocus;
    exit;
  end;

  if nvcbbpacked.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ���װ����!');
    nvcbbpacked.SetFocus;
    exit;
  end;

  if (Trim(nvedtpieces.Text) = '') then
  begin
    SysDialogs.ShowMessage('��������Ϊ��!');
    nvedtpieces.Text := '1';
    nvedtpieces.SetFocus;
    exit;
  end;

  if Trim(nvedtweight.Text) = '' then
  begin
    SysDialogs.ShowMessage('��������Ϊ��!');
    nvedtweight.Text := '1';
    nvedtweight.SetFocus;
    exit;
  end;

  { if Trim(nvedtvolume.Text) = '' then
    begin
    SysDialogs.ShowMessage('�������Ϊ��!');
    nvedtvolume.Text := '1';
    nvedtvolume.SetFocus;
    exit;
    end; }

  if Trim(nvedtsender.Text) = '' then
  begin
    SysDialogs.ShowMessage('�����˲���Ϊ��!');
    nvedtsender.SetFocus;
    exit;
  end;

  if Trim(nvedtsenderphone.Text) = '' then
  begin
    SysDialogs.ShowMessage('��������ϵ�绰����Ϊ��!');
    nvedtsenderphone.SetFocus;
    exit;
  end;

  if Trim(nvedtconsignee.Text) = '' then
  begin
    SysDialogs.ShowMessage('�ջ��˲���Ϊ��!');
    nvedtconsignee.SetFocus;
    exit;
  end;

  if Trim(nvedtconsigneephone.Text) = '' then
  begin
    SysDialogs.ShowMessage('�ջ�����ϵ�绰����Ϊ��!');
    nvedtconsigneephone.SetFocus;
    exit;
  end;

  //�ջ���֤����
//  if (Trim(nvedtcertificateno.Text) = '') then
//  begin
//     SysDialogs.ShowMessage('�ջ���֤���Ų���Ϊ��!');
//     nvedtcertificateno.SetFocus;
//     exit;
//    if nvcbbcertificatetype.ItemIndex < 0 then
//    begin
//      SysDialogs.ShowMessage('��ѡ��֤������!');
//      nvcbbcertificatetype.SetFocus;
//      exit;
//    end;
//    if nvcbbcertificatetype.ItemIndex = 0 then
//    begin
//      if not(ValidatePID(nvedtcertificateno.Text) = '') then
//      begin
//        SysDialogs.ShowMessage(ValidatePID(nvedtcertificateno.Text));
//        nvedtcertificateno.SetFocus;
//        exit;
//      end;
//    end;
//  end;

  if nvcbbshiptype.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������ʽ!');
    nvcbbshiptype.SetFocus;
    exit;
  end;

  if nvcbbpaymethod.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ�񸶿ʽ!');
    nvcbbpaymethod.SetFocus;
    exit;
  end;

  if (Trim(nvedtshipprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('���˷Ѳ���Ϊ��!');
    nvedtshipprice.SetFocus;
    exit;
  end;

  if (Trim(nvedtinsuredamount.Text) = '') then
  begin
    SysDialogs.ShowMessage('������ֵ����Ϊ��!');
    nvedtinsuredamount.Text := '0';
    nvedtinsuredamount.SetFocus;
    exit;
  end;

  if (Trim(nvedtinsurancefee.Text) = '') then
  begin
    SysDialogs.ShowMessage('���۷Ѳ���Ϊ��!');
    nvedtinsurancefee.Text := '0';
    nvedtinsurancefee.SetFocus;
    exit;
  end;

  if (Trim(nvedtpackfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('��װ�Ѳ���Ϊ��!');
    nvedtpackfee.Text := '0';
    nvedtpackfee.SetFocus;
    exit;
  end;

  if (Trim(nvedthandfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('װж�Ѳ���Ϊ��!');
    nvedthandfee.Text := '0';
    nvedthandfee.SetFocus;
    exit;
  end;

  if (Trim(nvedttransitfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('��ת�Ѳ���Ϊ��!');
    nvedttransitfee.Text := '0';
    nvedttransitfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtdeliveryfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('�ͻ��Ѳ���Ϊ��!');
    nvedtdeliveryfee.Text := '0';
    nvedtdeliveryfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtotherfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('�������ò���Ϊ��!');
    nvedtotherfee.Text := '0';
    nvedtotherfee.SetFocus;
    exit;
  end;

  if (Trim(nvedttotalfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('�ϼƽ���Ϊ��!');
    nvedttotalfee.Text := '0';
    nvedttotalfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtpackprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('���ջ����Ϊ��!');
    nvedtpackprice.Text := '0';
    nvedtpackprice.SetFocus;
    exit;
  end
  else
  begin
    if (nvcbbpaymethod.ItemIndex = 1) and
      (StrTofloat(Trim(nvedtpackprice.Text)) <= 0) then
    begin
      SysDialogs.ShowMessage('���ʽΪ�Ը������ջ����Ϊ0!');
      nvedtpackprice.Text := '0';
      nvedtpackprice.SetFocus;
      exit;
    end;
  end;

  if StrTofloat(nvedtshipprice.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('���˷ѽ����ֵ������Χ(0~9999.99)!');
    nvedtshipprice.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtinsuredamount.Text) >= 1000000 then
  begin
    SysDialogs.ShowMessage('������ֵ�����ֵ������Χ(0~999999.99)!');
    nvedtinsuredamount.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtinsurancefee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('���۷ѽ����ֵ������Χ(0~9999.99)!');
    nvedtinsurancefee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtpackfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('��װ�ѽ����ֵ����(0~9999.99)!');
    nvedtpackfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedthandfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('װж�ѽ����ֵ������Χ(0~9999.99)!');
    nvedthandfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedttransitfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('��ת�ѽ����ֵ������Χ(0~9999.99)!');
    nvedttransitfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtdeliveryfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('�ͻ��ѽ����ֵ������Χ(0~9999.99)!');
    nvedtdeliveryfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtotherfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('�������ý����ֵ������Χ(0~9999.99)!');
    nvedtotherfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedttotalfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('�ϼƽ����ֵ������Χ(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtpackprice.Text) >= 1000000 then
  begin
    SysDialogs.ShowMessage('���ջ�������ֵ������Χ(0~999999.99)!');
    nvedtpackprice.SetFocus;
    exit;
  end;

  with jcdspacksave do
  begin
    Active := false;
    if self.edittype = Tedittype.update then
    begin
      Params.ParamValues['pack.id'] := IntToStr(packid);
      Params.ParamValues['pack.createby'] := IntToStr(createby);
      Params.ParamValues['pack.createtime'] := FormatDateTime
        ('yyyy-mm-dd HH:mm:ss', createtime);
      Params.ParamValues['pack.onlycode'] := onlycode;
      Params.ParamValues['pack.synccode'] := synccode;
      // Params.ParamValues['pack.packno']:= packno;
      // Params.ParamByName('pack.invoiceno').Value := invoiceno;
      // Params.ParamByName('pack.orgid').Value :=IntToStr(orgid);

    end
    else
    begin
      if isdrawbill = '1' then
        packno := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill']
      else
        packno := nvedtpackno.Text;

      invoiceno := '';
      orgid := Sysinfo.LoginUserInfo.orgid;
      sellby := Sysinfo.LoginUserInfo.UserId;
    end;

    // packtype:string;//	;//varchar2(10)	y			�а����ͣ�0��������1������
    Params.ParamByName('pack.packtype').Value := '0';

    // goodtype:string;//�������
    Params.ParamByName('pack.goodtype').Value := 0;
    // sendstationid:Integer;//number(10)	y			����վ
    Params.ParamByName('pack.sendstationid').Value :=
      Sysinfo.LoginUserInfo.StationID;
    // tostationid:Integer;//number(10)	n			Ŀ�ĵ�
    Params.ParamByName('pack.tostationid').Value := IntToStr
      (nvhelptostation.Id);
    // name:string;//varchar2(50)	n			��������
    Params.ParamByName('pack.name').Value := nvcbbgoodname.Text;
    // scheduleid:Integer;//number(10)	y			���
    Params.ParamByName('pack.scheduleid').Value := nvhelpschedule.Id;
    packstatus := '0'; // ���

    // depart:TDateTime;//date	;//date	y			��������������
    Params.ParamByName('pack.departdate').Value := FormatDateTime('yyyy-mm-dd',
      dtpdepartdate.DateTime);
    // packno:string;//varchar2(20)	y			�а�����
    Params.ParamByName('pack.packno').Value := packno;
    // invoiceno:string;//varchar2(20)	y			��Ʊ��
    Params.ParamByName('pack.invoiceno').Value := invoiceno;

    // sellby:Integer;//number(10)	y			����Ա
    Params.ParamByName('pack.sellby').Value := IntToStr(sellby);

    Params.ParamByName('pack.collectby').Value := IntToStr(sellby); // ������  ��������
    Params.ParamByName('pack.collectdate').Value := FormatDateTime
      ('yyyy-mm-dd', Now());

    // pieces:Integer;//number(3)	y			����
    Params.ParamByName('pack.pieces').Value := Trim(nvedtpieces.Text);
    // weight:Integer;//number(3)	y			��
    Params.ParamByName('pack.weight').Value := Trim(nvedtweight.Text);
    // volume:string;//varchar2(20)	y			���
    Params.ParamByName('pack.volume').Value := '0';
    if isinputpacked then
    begin
      Params.ParamByName('pack.packed').Value := packaed; // �ֶ������װ���
    end
    else
    begin
      // packaed:Double;//varchar2(10)	y			��װ��ֽ�䡢���ϴ����ޣ�
      Params.ParamByName('pack.packed').Value := nvcbbpacked.GetSelectCode;
    end;
    // shipprice:Double;//number(6,2)	y			���˷�
    Params.ParamByName('pack.shipprice').Value := Trim(nvedtshipprice.Text);
    // packfee:Double;//number(6,2)	y			��װ��
    Params.ParamByName('pack.packfee').Value := Trim(nvedtpackfee.Text);
    // handfee:Double;//number(6,2)	y			װж��
    Params.ParamByName('pack.handfee').Value := Trim(nvedthandfee.Text);
    // deliveryfee:Double;//                         �ͻ���
    Params.ParamByName('pack.deliveryfee').Value := Trim(nvedtdeliveryfee.Text);
    // custodial:Double;//number(6,2)	y			���ܷ�
    Params.ParamByName('pack.custodial').Value := '0';
    // transitfee:Double;//number(6,2)	y			��ת��
    Params.ParamByName('pack.transitfee').Value := Trim(nvedttransitfee.Text);
    // insuredamount:Double;//number(6,2)	y			���۽��
    Params.ParamByName('pack.insuredamount').Value := Trim
      (nvedtinsuredamount.Text);
    // insurancefee:Double;//number(6,2)	y			���۷�
    Params.ParamByName('pack.insurancefee').Value := Trim
      (nvedtinsurancefee.Text);
    // insurance:Double;//number(6,2)	y			���շ�
    Params.ParamByName('pack.insurance').Value := '0';
    // otherfee:Double;//number(6,2)	y			��������
    Params.ParamByName('pack.otherfee').Value := Trim(nvedtotherfee.Text);
    // otherfee:Double;//number(6,2)	y			�����
    Params.ParamByName('pack.servicefee').Value := Trim(nvedtservicefee.Text);
    // totalfee:Double;//number(6,2)	y			�ϼƽ��
    Params.ParamByName('pack.totalfee').Value := Trim(nvedttotalfee.Text);
    // �ֿۻ��ֽ��
    Params.ParamByName('pack.integraterprice').Value := Trim
      (nvedtIntegrateMoney.Text);
    // location:string;//varchar2(20)	y			���λ��
    // packprice:Double;//number(6,2)	y			���ջ���
    Params.ParamByName('pack.packprice').Value := Trim(nvedtpackprice.Text);
    // sender:string;//varchar2(30)	y			������
    Params.ParamByName('pack.sender').Value := Trim(nvedtsender.Text);
    // senderphone:string;//varchar2(20)	y			�����˵绰
    Params.ParamByName('pack.senderphone').Value := Trim(nvedtsenderphone.Text);
    // senderaddress:string;//varchar2(100)	y			�����˵�ַ
    Params.ParamByName('pack.senderaddress').Value := Trim
      (nvedtsenderaddress.Text);
    // consignee:string;//varchar2(30)	y			�ջ���
    Params.ParamByName('pack.consignee').Value := Trim(nvedtconsignee.Text);
    // consigneephone:string;//varchar2(20)	y			�ջ��˵绰
    Params.ParamByName('pack.consigneephone').Value := Trim
      (nvedtconsigneephone.Text);
    // consigneeaddress:string;//varchar2(100)	y			�ջ��˵�ַ
    Params.ParamByName('pack.consigneeaddress').Value := Trim
      (nvedtconsigneeaddress.Text);

    // certificatetype:string;//varchar2(10)	y			֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
    if (nvcbbcertificatetype.ItemIndex >= 0) then
      Params.ParamByName('pack.certificatetype').Value :=
        nvcbbcertificatetype.GetSelectCode
    else
      Params.ParamByName('pack.certificatetype').Value := '-1';

    // certificateno:string;//varchar2(30)	y			֤������
    if (Trim(nvedtcertificateno.Text)='') then
         Params.ParamByName('pack.certificateno').Value := '��'
    else
        Params.ParamByName('pack.certificateno').Value := Trim
          (nvedtcertificateno.Text);

    // shiptype:string;//varchar2(10)	y			���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
    Params.ParamByName('pack.shiptype').Value := nvcbbshiptype.GetSelectCode;
    // paymethod:string;//varchar2(10)	y			���ʽ���ָ����Ḷ��ȡ�����ֵ�
    Params.ParamByName('pack.paymethod').Value := nvcbbpaymethod.GetSelectCode;

    if (nvcbbpaymethod.GetSelectCode = '1') then
    begin
      Params.ParamByName('pack.collectstatus').Value := '1'; // �Ѵ���
      Params.ParamByName('pack.recyclestatus').Value := '0'; // �����������״̬
    end
    else
    begin
      Params.ParamByName('pack.collectstatus').Value := '0'; // δ����
    end;

    // valuables:string;//number(1)	y			�Ƿ������Ʒ
    if rbvaluablesno.checked then
      Params.ParamByName('pack.valuables').Value := false
    else
      Params.ParamByName('pack.valuables').Value := True;

    // status:string;//varchar2(10)	y			״̬(0����桢1��ǩ����2�����졢3������)
    Params.ParamByName('pack.status').Value := packstatus;
    // orgid:Integer;//number(10)	y
    Params.ParamByName('pack.orgid').Value := IntToStr(orgid);
    // packtturnoverid:string;//number(10)	y			�ɿ�id
    // remak:string;//varchar2(50)	y			��ע
    Params.ParamByName('pack.remak').Value := Trim(memremarks.Text);

    if (nvhelpclient.Id > 0) and (nvhelpclient.Text <> '') then
    begin
      Params.ParamByName('pack.clientid').Value := nvhelpclient.Id;
    end
    else
    begin
      Params.ParamByName('pack.clientid').Value := '';
    end;

    // createtime:TDateTime;//date	n	sys;//date
    // createby:Integer;//number(10)	n
    // updatetime:TDateTime;//date	n	sys;//date
    // updateby:Integer;//number(10)	n

    // ===============����������ˮ��Ϣ====================
    if (nvhelpclient.Id > 0) and (nvhelpclient.Text <> '') then
    begin
      Params.ParamByName('packIntegraterPay.clientid').Value := nvhelpclient.Id;
    end
    else
    begin
      Params.ParamByName('packIntegraterPay.clientid').Value := '';
    end;
    // orgid:Integer;//number(10)	y
    Params.ParamByName('packIntegraterPay.orgid').Value := IntToStr(orgid);
    Params.ParamByName('packIntegraterPay.price').Value := Trim
      (nvedtIntegrateMoney.Text);
    // Params.ParamByName('packIntegraterPay.integrater').Value :=IntToStr(integrater-StrToInt(Trim(nvedtintegrate.Text)));
    Params.ParamByName('packIntegraterPay.integrater').Value := Trim
      (nvedtintegrate.Text);
    // Params.ParamByName('integrate.integrater').Value := Trim(nvedtintegrate.Text);
    // ===================================================
    bbtnSave.Enabled := false;
    Execute;
    bbtnSave.Enabled := True;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled := false;
      if packid > 0 then
        result := '�޸�'

      else
      begin
        result := '���';
      end;

      log := result + VarToStr(Params.ParamValues['packid'])
        + '�а�������������=' + orgname + ',' + result + '��=' +
        Sysinfo.LoginUserInfo.UserName + ',�а�����=' + packno + ',��Ʊ��=' +
        invoiceno + ',���=' + schedulename + ',���ƺ�=' + vehiclecodename +
        ',Ŀ�ĵ�=' + nvhelptostation.Value + ',��������=' +
        nvcbbgoodname.Text + ',�������=0,��װ����=' + nvcbbpacked.Text + ',����=' +
        nvedtpieces.Text + ',����=' + nvedtweight.Text + ',������=' +
        nvedtsender.Text + ',��������ϵ�绰=' + nvedtsenderphone.Text + ',�ջ���=' +
        nvedtconsignee.Text + ',�ջ�����ϵ�绰=' + nvedtconsigneephone.Text +
        ',֤������=' + nvcbbcertificatetype.Text + ',�ջ���֤������=' +
        nvedtcertificateno.Text + ',�����ʽ=' + nvcbbshiptype.Text + ',���ʽ=' +
        nvcbbpaymethod.Text + ',���˷�=' + nvedtshipprice.Text + ',������ֵ=' +
        nvedtinsuredamount.Text + ',���۷�=' + nvedtinsurancefee.Text + ',��װ��=' +
        nvedtpackfee.Text + ',װж��=' + nvedthandfee.Text + ',��ת��=' +
        nvedttransitfee.Text + ',�ͻ���=' + nvedtdeliveryfee.Text + ',��������=' +
        nvedtotherfee.Text + ',�ϼƽ��=' + nvedttotalfee.Text + ',���ջ���=' +
        nvedtpackprice.Text + ',״̬=' + packstatus;
      SysLog.WriteLog('�а�����->�а�����', result, log);

      try
        Foperationid := Params.ParamValues['packid'];
        if getParametervalue('8016', Sysinfo.LoginUserInfo.orgid) = '1' then
        begin
          // �Ƿ��ӡ����
          if self.edittype = Tedittype.add then
          begin
            printpack;
          end;
        end;

        if packstatus = '1' then
        begin
          // ǩ�� ��ӡǩ����
          packissue;
        end;

      finally
        if isdrawbill = '1' then
        begin
          updatepackbill;
        end;

        self.ModalResult := mrOk;
      end;

    end;

  end;
end;

procedure TFrmPackacceptAdd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  nvcbbgoodname.Active := false;
  nvcbbgoodname.Active := false;
  nvcbbcertificatetype.Active := false;
  nvcbbshiptype.Active := false;
  nvcbbpaymethod.Active := false;
end;

procedure TFrmPackacceptAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbgoodname.Active := True;
  nvcbbpacked.Active := True;
  nvcbbcertificatetype.Active := True;
  nvcbbshiptype.Active := True;
  nvcbbpaymethod.Active := True;
  nvedtsendtype.Active := True;
  nvedtpacked.Visible := false;

      nvcbbgoodname.ItemIndex := 0;
    nvcbbpacked.ItemIndex := 1;
    nvcbbcertificatetype.ItemIndex := -1;
    nvcbbshiptype.ItemIndex := 0;
    nvcbbpaymethod.ItemIndex := 0;

  with jcdsParameters do
  begin
    Active := false;
    Params.ParamValues['code'] :=
      '''8001'',''8002'',''8003'',''8004'',''8005'',''8006'',''8017''';
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.orgid;
    Active := True;
    if RecordCount > 0 then
    begin
      insurancevalue := FieldByName('8001').AsFloat;
      insurancefeevalue := FieldByName('8002').AsFloat;
      insuranceboolean := FieldByName('8003').AsInteger;
      insurancefeeboolean := FieldByName('8004').AsInteger;
      isprintInvoice := FieldByName('8005').AsString;
      p8006 := FieldByName('8006').AsString;
      isdrawbill := FieldByName('8017').AsString;
    end;
  end;

  if insuranceboolean = 0 then
  begin
    // Label46.Visible := false;
    // nvedtinsurance.Visible := false;
    // Label47.Visible := false;
  end;

  if insurancefeeboolean = 0 then
  begin
    nvedtinsurancefee.Visible := false;
    Label50.Visible := false;
    Label53.Visible := false;
  end;
  nvedtservicefee.Text := '0';
end;

procedure TFrmPackacceptAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then

  else
  begin
    dtpdepartdate.DateTime := Now();
//    nvcbbgoodname.ItemIndex := 0;
//    nvcbbpacked.ItemIndex := 1;
//    nvcbbcertificatetype.ItemIndex := -1;
//    nvcbbshiptype.ItemIndex := 0;
//    nvcbbpaymethod.ItemIndex := 0;
    if isdrawbill = '1' then
    begin
      nvedtpackno.Text := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
      nvedtpackno.Enabled := false;
      nvhelptostation.SetFocus
    end
    else
      nvedtpackno.SetFocus;

  end;
  if p8006 = '1' then
  begin
    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackSgBill')
      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackSgBill') and
      (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] > 0) then
    begin

    end;
  end;
  nvedtsendtypeChange(Sender);
  if percent > 0 then
  begin
    nvedtsendintegrater.Text := FloatToStr
      (Ceil(StrTofloat(Trim(nvedtIntegrateMoney.Text)) / percent) + StrTofloat
        (Trim(nvedtsendintegrater.Text)));
    nvedtintegrate.Text := FloatToStr
      (Ceil(StrTofloat(Trim(nvedtIntegrateMoney.Text)) / percent));
    // nvedtintegrate.Enabled:=False;
  end;
  // integrater:=StrToInt(trim(nvedtintegrate.Text));
  // computePayMoney;
end;

procedure TFrmPackacceptAdd.nvcbbpackedChange(Sender: TObject);
begin
  inherited;
  if nvcbbpacked.ItemIndex = 0 then
  begin
    nvedtpacked.Visible := True;
    nvedtpacked.Enabled := True;
  end
  else
  begin
    nvedtpacked.Visible := false;
    nvedtpacked.Text := '';
  end;
end;

procedure TFrmPackacceptAdd.nvedtconsigneephoneKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_return then
  begin
    nvedttotalfee.SetFocus;
  end;
  if Key = vk_escape then
  begin
    if (GetParentForm(self).ActiveControl is Tcombobox) then
      if (GetParentForm(self).ActiveControl as Tcombobox)
        .Style in [csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable] then
        Key := 0;
    selectnext(GetParentForm(self).ActiveControl, false, True);
  end;
end;

procedure TFrmPackacceptAdd.nvedtinsuredamountChange(Sender: TObject);
begin
  inherited;

  if (Trim(nvedtinsuredamount.Text) <> '') then
  begin
    // ������ֵ
    if StrTofloat(nvedtinsuredamount.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('���۽����ֵ������Χ(0~999999.99)!');
      nvedtinsuredamount.SetFocus;
      exit;
    end;
  end;

  if nvedtinsuredamount.Text = '' then
    exit;

  { if insuranceboolean <> 0 then
    begin
    nvedtinsurance.Text := FloatToStr(StrToFloat(nvedtinsuredamount.Text)
    * insurancevalue);
    end; }

  if insurancefeeboolean <> 0 then
  begin
    // nvedtinsurancefee.Text := FloatToStr(StrToFloat(nvedtinsuredamount.Text)
    // * insurancefeevalue);
    if ((ceil(StrTofloat(nvedtinsuredamount.Text)) mod 10) = 0) then
      begin
        nvedtinsurancefee.Text := FloatToStr(StrTofloat(nvedtinsuredamount.Text) * insurancefeevalue);
      end
    else
      begin
        nvedtinsurancefee.Text := FloatToStr
        (Ceil(StrTofloat(nvedtinsuredamount.Text) * insurancefeevalue));  // �������ȡ����ʽ
      end;
  end;
end;

procedure TFrmPackacceptAdd.nvedtpackedExit(Sender: TObject);
var
  str1: String;
var
  str2: String;
var
  idx: Integer;
begin
  inherited;
  isinputpacked := True;
  str1 := nvcbbpacked.Items.Text;
  str2 := Trim(nvedtpacked.Text);

  idx := nvcbbpacked.Items.IndexOf(str2);
  if idx <0 then
    begin
             //�°�װ��ʽ
      if str2 <> '' then
      with jcdspacktypesave do
      begin
        Params.ParamValues['newPackType'] := str2;
        Execute;
      end;
      idx := nvcbbpacked.Items.Count; // Ŀǰ�Ѵ���Ԫ�ظ���
      packaed := IntToStr(idx); // packaed�������ֵ��0��ʼ����
    end
  else
    begin
      packaed := IntToStr(idx);
    end;
//  if Pos(str2, str1) > 0 then
//  begin
//    // �Ѵ���������İ�װ��ʽ
//    // idx := nvcbbpacked.Items.IndexOfName(str2);
//    idx := nvcbbpacked.Items.IndexOf(str2);
//    packaed := IntToStr(idx);
//  end
//  else
//  begin
//    if str2 <> '' then
//      with jcdspacktypesave do
//      begin
//        Params.ParamValues['newPackType'] := str2;
//        Execute;
//      end;
//    idx := nvcbbpacked.Items.Count; // Ŀǰ�Ѵ���Ԫ�ظ���
//    packaed := IntToStr(idx); // packaed�������ֵ��0��ʼ����
//  end;

end;

procedure TFrmPackacceptAdd.nvedtpacknoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if Trim(nvedtpackno.Text) = '' then
      exit;
  end;
end;

procedure TFrmPackacceptAdd.nvedtPayMoneyExit(Sender: TObject);
begin
  inherited;
  bbtnSave.SetFocus;
end;

procedure TFrmPackacceptAdd.nvedtsenderphoneKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
  begin
    nvedtconsignee.SetFocus;
  end;
  if Key = vk_escape then
  begin
    if (GetParentForm(self).ActiveControl is Tcombobox) then
      if (GetParentForm(self).ActiveControl as Tcombobox)
        .Style in [csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable] then
        Key := 0;
    selectnext(GetParentForm(self).ActiveControl, false, True);
  end;

end;

procedure TFrmPackacceptAdd.nvedtsendtypeChange(Sender: TObject);
begin
  inherited;
  with jsdcQueryPercent do
  begin
    Active := false;
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.orgid;
    Params.ParamValues['clienttype'] := nvedtsendtype.ItemIndex;
    Active := True;
  end;
  if jsdcQueryPercent.FieldByName('percent').AsString <> '' then
  begin
    percent := jsdcQueryPercent.FieldByName('percent').AsFloat;
  end;

end;

procedure TFrmPackacceptAdd.nvedtshippriceChange(Sender: TObject);
begin
  inherited;
  totalfeemoney;
end;

procedure TFrmPackacceptAdd.nvedttotalfeeChange(Sender: TObject);
begin
  inherited;
  computePayMoney;
end;

procedure TFrmPackacceptAdd.nvedtIntegrateChange(Sender: TObject);
var
  integral, availableIntegral: double;
begin
  inherited;
  { with jcdsIntegrateToMoney do
    begin
    Active := false;
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.orgid;
    Params.ParamValues['integrater'] := nvedtintegrate.Text;
    Params.ParamValues['clienttype'] := nvedtsendtype.ItemIndex;
    Active := True;
    end;
    if jcdsIntegrateToMoney.FieldByName('money').AsString <> '' then
    begin
    nvedtIntegrateMoney.Text := jcdsIntegrateToMoney.FieldByName('money')
    .AsString;
    end; }
  integral := StrTofloat(Trim(nvedtintegrate.Text));
  availableIntegral := StrTofloat(Trim(nvedtsendintegrater.Text));
  if availableIntegral < integral then
  begin
    nvedtintegrate.Text := FloatToStr(availableIntegral);
    nvedtIntegrateMoney.Text := FloatToStr
      (trunc(percent * availableIntegral * 100) / 100);
    SysDialogs.ShowMessage('�ֿۻ��ֲ��ܳ�����ǰ���û���!');
    nvedtintegrate.SetFocus;
    exit;
  end
  else
  begin
    nvedtIntegrateMoney.Text := FloatToStr
      (trunc(percent * integral * 100) / 100);
  end;

end;

procedure TFrmPackacceptAdd.nvedtweightChange(Sender: TObject);
begin
  inherited;
  shippricemoney;

end;

procedure TFrmPackacceptAdd.nvedtweightExit(Sender: TObject);
begin
  inherited;
  nvedtsender.SetFocus;
end;

procedure TFrmPackacceptAdd.nvhelpclientIdChange(Sender: TObject);
begin
  inherited;

  if (nvhelpclient.Id > 0) and (nvhelpclient.Text <> '') then
  begin
    nvhelpclient.Text := nvhelpclient.HelpFieldValue['code'];

    nvedtsendintegrater.Text := nvhelpclient.HelpFieldValue['integrater'];
    nvedtsendtype.ItemIndex := (Integer(nvhelpclient.HelpFieldValue['type']));

    if nvhelpclient.HelpFieldValue['contacter'] <> null then
      nvedtsender.Text := nvhelpclient.HelpFieldValue['contacter']
    else
      nvedtsender.Text := nvhelpclient.HelpFieldValue['name'];

    if nvhelpclient.HelpFieldValue['mobilephone'] <> null then
      nvedtsenderphone.Text := nvhelpclient.HelpFieldValue['mobilephone']
    else
      nvedtsenderphone.Text := '';
    if nvhelpclient.HelpFieldValue['address'] <> null then
      nvedtsenderaddress.Text := nvhelpclient.HelpFieldValue['address']
    else
      nvedtsenderaddress.Text := '';
    if nvedtsendtype.ItemIndex >= 0 then
    begin
      with jsdcQueryPercent do
      begin
        Active := false;
        Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.orgid;
        Params.ParamValues['clienttype'] := nvedtsendtype.ItemIndex;
        Active := True;
      end;
      if jsdcQueryPercent.FieldByName('percent').AsString <> '' then
      begin
        percent := jsdcQueryPercent.FieldByName('percent').AsFloat;
      end;
    end;
    nvedtconsignee.SetFocus;
  end
  else
  begin
    nvedtsender.Text := '';
    nvedtsenderphone.Text := '';
    nvedtsenderaddress.Text := '';
    nvedtsendtype.ItemIndex := -1;
    nvedtsendintegrater.Text := '0';
  end;
end;

procedure TFrmPackacceptAdd.nvhelpscheduleChange(Sender: TObject);
begin
  inherited;

  if nvhelptostation.Id <= 0 then
  begin
    SysDialogs.ShowMessage('������Ŀ�ĵ�!');
    nvedtshipprice.Clear;
    nvhelptostation.SetFocus;
    exit;
  end;

  if StrToInt(FormatDateTime('yyyyMMdd', dtpdepartdate.DateTime)) < StrToInt
    (FormatDateTime('yyyyMMdd', Now())) then
  begin
    SysDialogs.ShowMessage('�������ڲ���С�ڽ���!');
    dtpdepartdate.SetFocus;
    exit;
  end;


   if (nvhelptostation.Id > 0) then
   begin
      with nvhelpschedule do // ���
      begin
        Params.ParamValues['filter_EQD_tp!departdate'] := FormatDateTime
          ('yyyy-mm-dd', dtpdepartdate.DateTime);
        Params.ParamValues['filter_EQL_tp!reachstationid'] := nvhelptostation.Id;
        Params.ParamValues['filter_EQL_tp!departstationid'] :=
          Sysinfo.LoginUserInfo.StationID;
      end;
    end
    else
    begin
       nvhelpschedule.Clear;
    end;


  // Sysdialogs.ShowMessage(IntToStr(nvhelptostation.Id)+'   '+IntToStr(SysInfo.LoginUserInfo.OrgID)+'  '+FormatDateTime('yyyy-MM-dd', dtpdepartdate.DateTime));

end;

procedure TFrmPackacceptAdd.nvhelpscheduleClick(Sender: TObject);
begin
  inherited;
  {
    if nvhelptostation.Id<=0 then
    begin
    SysDialogs.ShowMessage('������Ŀ�ĵ�!');
    nvhelptostation.SetFocus;
    exit;
    end;

    if StrToInt(FormatDateTime('yyyyMMdd', dtpdepartdate.DateTime))<StrToInt(FormatDateTime('yyyyMMdd', Now())) then
    begin
    SysDialogs.ShowMessage('�������ڲ���С�ڽ���!');
    dtpdepartdate.SetFocus;
    exit;
    end;
    Sysdialogs.ShowMessage(IntToStr(nvhelptostation.Id)+'   '+IntToStr(SysInfo.LoginUserInfo.OrgID)+'  '+FormatDateTime('yyyy-MM-dd', dtpdepartdate.DateTime));
    with nvhelpschedule do
    begin
    Params.ParamValues['filter_EQL_rt!stationid'] :=nvhelptostation.Id;
    Params.ParamValues['filter_EQL_v!reportorgid'] :=SysInfo.LoginUserInfo.OrgID;
    // Params.ParamValues['filter_EQL_ss!isdeparted'] :='1';
    Params.ParamValues['filter_INS_ss!status'] :='(0,2,4,5)';
    Params.ParamValues['filter_GED_ss!departdate'] :=FormatDateTime('yyyy-MM-dd', dtpdepartdate.DateTime);
    //Params.ParamValues['filter_LED_ss!departdate'] :=FormatDateTime('yyyy-MM-dd', dtpdepartdate.DateTime);
    end;
    }
end;

procedure TFrmPackacceptAdd.nvhelptostationIdChange(Sender: TObject);
var
  ids: String;
begin
  inherited;

  distance := 0;
  if (nvhelptostation.Id > 0) then
  begin

//    if flag then
//    begin
      with jcdsdistance do
      begin
        Active := false;
        Params.ParamValues['filter_EQL_r!orgid'] := Sysinfo.LoginUserInfo.orgid;
        Params.ParamValues['filter_EQL_t!stationid'] := nvhelptostation.Id;

        // Active :=true;
        Execute;
        if Params.ParamValues['distance'] <> '' then
        begin
          distance := Params.ParamValues['distance'];
          nvedtdistance.Text := IntToStr(distance);
        end;
      end;
      shippricemoney;
//    end;

    { begin
      with jcdsQueryRoutes do
      begin
      // Active := false;
      close;
      Params.ParamValues['filter_EQL_s!id'] := nvhelptostation.Id;
      execute;
      ids := Params.ParamByName('ids').Value;
      // Active := true;
      end;
      end; }

    with nvhelpschedule do // ���
    begin
      Params.ParamValues['filter_EQD_tp!departdate'] := FormatDateTime
        ('yyyy-mm-dd', dtpdepartdate.DateTime);
      Params.ParamValues['filter_EQL_tp!reachstationid'] := nvhelptostation.Id;
      Params.ParamValues['filter_EQL_tp!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
    end;

  end
  else
  begin
     nvhelpschedule.Clear;
  end;

end;

procedure TFrmPackacceptAdd.shippricemoney();
var
  piecesmoney, weightmoney, packnum: double;
  deliveryfee : Integer; //�ͻ���
begin
  // ���˷ѡ���ת�� ���ͻ��ѣ�������
  with jcdsquerypackfee do
  begin
    Active := false;
    Params.ParamValues['pieces'] := Trim(nvedtpieces.Text);
    Params.ParamValues['weight'] := Trim(nvedtweight.Text);
    Params.ParamValues['distance'] := distance;
    Execute;
   { if Params.ParamValues['shipprice']=0 then
    begin
       SysDialogs.ShowMessage('�շѱ�׼δ����˹�����!');
    end;  }

    // ���˷�
    nvedtshipprice.Text := FloatToStr(Params.ParamValues['shipprice']);
    // װж��
    nvedthandfee.Text := FloatToStr(Params.ParamValues['handfee']);
    //�ͻ���
    deliveryfee := StrToInt(getParametervalue('8022', Sysinfo.LoginUserInfo.OrgID));
    nvedtdeliveryfee.Text := inttostr(deliveryfee * strtoint(Trim(nvedtweight.Text)));
  end;

end;

procedure TFrmPackacceptAdd.totalfeemoney();
var
  totalfeemoney, paymoney: double;
begin
  if (Trim(nvedtshipprice.Text) <> '') then
  begin
    // ���˷�
    if StrTofloat(nvedtshipprice.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('���˷ѽ����ֵ������Χ(0~9999.99)!');
      nvedtshipprice.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtshipprice.Text));
  end;

  { if (Trim(nvedtinsurance.Text) <> '') then
    begin
    // ���շ�
    if StrToFloat(nvedtinsurance.Text) >= 10000 then
    begin
    SysDialogs.ShowMessage('���շѽ����ֵ������Χ(0~9999.99)!');
    nvedtinsurance.SetFocus;
    exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(Trim(nvedtinsurance.Text));
    end; }

  if (Trim(nvedtinsurancefee.Text) <> '') then
  begin
    // ���۷�
    if StrTofloat(nvedtinsurancefee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('���۷ѽ����ֵ������Χ(0~9999.99)!');
      nvedtinsurancefee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtinsurancefee.Text));
  end;

  if (Trim(nvedtpackfee.Text) <> '') then
  begin
    // ��װ��
    if StrTofloat(nvedtpackfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('��װ�ѽ����ֵ������Χ(0~9999.99)!');
      nvedtpackfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtpackfee.Text));
  end;

  if (Trim(nvedthandfee.Text) <> '') then
  begin
    // װж��
    if StrTofloat(nvedthandfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('װж�ѽ����ֵ������Χ(0~9999.99)!');
      nvedthandfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedthandfee.Text));
  end;

  if (Trim(nvedttransitfee.Text) <> '') then
  begin
    // ��ת��
    if StrTofloat(nvedttransitfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('��ת�ѽ����ֵ������Χ(0~9999.99)!');
      nvedttransitfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedttransitfee.Text));
  end;

  if (Trim(nvedtdeliveryfee.Text) <> '') then
  begin
    // �ͻ���
    if StrTofloat(nvedtdeliveryfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('�ͻ��ѽ����ֵ������Χ(0~9999.99)!');
      nvedtdeliveryfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtdeliveryfee.Text));
  end;

  if (Trim(nvedtservicefee.Text) <> '') then
  begin
    // �����
    if StrTofloat(nvedtservicefee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('������ý����ֵ������Χ(0~9999.99)!');
      nvedtservicefee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtservicefee.Text));
  end;

  if (Trim(nvedtotherfee.Text) <> '') then
  begin
    // ��������
    if StrTofloat(nvedtotherfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('�������ý����ֵ������Χ(0~9999.99)!');
      nvedtotherfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtotherfee.Text));
  end;

  nvedttotalfee.Text := FloatToStr(totalfeemoney);

  if totalfeemoney >= 10000 then
  begin
    SysDialogs.ShowMessage('�ϼƽ����ֵ������Χ(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

end;

procedure TFrmPackacceptAdd.printpack();
begin
  FrmPackacceptReport := TFrmPackacceptReport.Create(self);
  with FrmPackacceptReport do
  begin
    // goodtype:string;//�������
    goodtype := '0';
    // sendstationid:Integer;//number(10)	y			����վ
    sendstationvalue := Sysinfo.LoginUserInfo.ticketoutletsname;
    // tostationid:Integer;//number(10)	n			Ŀ�ĵ�
    tostationvalue := nvhelptostation.Text;
    // name:string;//varchar2(50)	n			��������
    name := nvcbbgoodname.Text;
    // scheduleid:Integer;//number(10)	y			���
    schedulevalue := schedulename; // nvhelpschedule.HelpFieldValue['code'];
    // vehicleid:Integer;//number(10)	n			���ƺ�
    vehiclevalue := vehiclecodename; // nvhelpschedule.HelpFieldValue['name'];;
    // depart:TDateTime;//date	;//date	y			��������������
    departdate := FormatDateTime('yyyy-MM-dd', dtpdepartdate.DateTime);
    departtime := self.departtime;
    // packno:string;//varchar2(20)	y			�а�����
    packno := self.packno;
    // invoiceno:string;//varchar2(20)	y			��Ʊ��
    invoiceno := self.invoiceno;
    sellbyname := Sysinfo.LoginUserInfo.UserName;
    selltime := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now()); // ����ʱ��
    // pieces:Integer;//number(3)	y			����
    pieces := Trim(nvedtpieces.Text);
    // weight:Integer;//number(3)	y			��
    weight := Trim(nvedtweight.Text);
    // volume:string;//varchar2(20)	y			���
    volume := '0';
    // packaed:Double;//varchar2(10)	y			��װ��ֽ�䡢���ϴ����ޣ�
    packaed := '��';
    // shipprice:Double;//number(6,2)	y			���˷�
    shippricemoney := Trim(nvedtshipprice.Text);
    // packfee:Double;//number(6,2)	y			��װ��
    packfeemoney := Trim(nvedtpackfee.Text);
    // handfee:Double;//number(6,2)	y			װж��
    handfeemoney := Trim(nvedthandfee.Text);
    // deliveryfee:Double;//                         �ͻ���
    deliveryfeemoney := Trim(nvedtdeliveryfee.Text);
    // custodial:Double;//number(6,2)	y			���ܷ�
    custodialmoney := '0';
    // transitfee:Double;//number(6,2)	y			��ת��
    transitfeemoney := Trim(nvedttransitfee.Text);
    // insuredamount:Double;//number(6,2)	y			���۽��
    insuredamountmoney := Trim(nvedtinsuredamount.Text);
    // insurancefee:Double;//number(6,2)	y			���۷�
    insurancefeemoney := Trim(nvedtinsurancefee.Text);
    // insurance:Double;//number(6,2)	y			���շ�
    insurancemoney := '';
    // servicefeemoney:Double;//number(6,2)	y			�����
    servicefeemoney :=Trim(nvedtservicefee.Text);
    // otherfee:Double;//number(6,2)	y			��������
    otherfeemoney := Trim(nvedtotherfee.Text);
    // totalfee:Double;//number(6,2)	y			�ϼƽ��
    totalfeemoney := Trim(nvedttotalfee.Text);
    // location:string;//varchar2(20)	y			���λ��
    // packprice:Double;//number(6,2)	y			���ջ���
    packpricemoney := Trim(nvedtpackprice.Text);
    // �ϼƽ��+���ջ���
    if (nvcbbpaymethod.GetSelectCode = '0') then
      // �ָ�
      totalprice := FloatToStr(StrTofloat(Trim(nvedtpackprice.Text)))
    else
      // �Ḷ
      totalprice := FloatToStr(StrTofloat(Trim(nvedtpackprice.Text))
          + StrTofloat(Trim(nvedttotalfee.Text)));

    // sender:string;//varchar2(30)	y			������
    Sender := Trim(nvedtsender.Text);
    // senderphone:string;//varchar2(20)	y			�����˵绰
    senderphone := Trim(nvedtsenderphone.Text);
    // senderaddress:string;//varchar2(100)	y			�����˵�ַ
    senderaddress := Trim(nvedtsenderaddress.Text);
    // consignee:string;//varchar2(30)	y			�ջ���
    consignee := Trim(nvedtconsignee.Text);
    // consigneephone:string;//varchar2(20)	y			�ջ��˵绰
    consigneephone := Trim(nvedtconsigneephone.Text);
    // consigneeaddress:string;//varchar2(100)	y			�ջ��˵�ַ
    consigneeaddress := Trim(nvedtconsigneeaddress.Text);
    // certificatetype:string;//varchar2(10)	y			֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
    certificatetype := nvcbbcertificatetype.GetSelectValue;
    // certificateno:string;//varchar2(30)	y			֤������
    certificateno := Trim(nvedtcertificateno.Text);
    // shiptype:string;//varchar2(10)	y			���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
    shiptype := nvcbbshiptype.GetSelectValue;
    // paymethod:string;//varchar2(10)	y			���ʽ���ָ����Ḷ��ȡ�����ֵ�
    paymethod := nvcbbpaymethod.GetSelectValue;
    // valuables:string;//number(1)	y			�Ƿ������Ʒ
    if rbvaluablesno.checked then
      valuables := '��'
    else
      valuables := '��';
    remarks := Trim(memremarks.Text); // ��������

    PrintPackReport;

    if isprintInvoice = '1' then
    begin
       PrintPackInvoiceReport; //��ӡ��Ʊ
    end;

  end;

  ModalResult := mrOk;

end;

procedure TFrmPackacceptAdd.rbnoclientClick(Sender: TObject);
begin
  inherited;
  lblunitid.Visible := false;
  nvhelpclient.Visible := false;
  nvedtsender.Text := '';
  nvedtsenderphone.Text := '';
end;

procedure TFrmPackacceptAdd.updatepackbill();
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
    Active := false;
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

procedure TFrmPackacceptAdd.packissue();
var
  i: Integer;
  scheduleid, vehicleid, routeid: string;
  drivername, vehunitname: string;
begin
  inherited;
  if getParametervalue('8006', Sysinfo.LoginUserInfo.orgid) = '1' then
  begin

    with jcdsResult do
    begin
      Active := false;

      // Params.ParamValues['filter_EQL_vep!reportorgid'] :=SysInfo.LoginUserInfo.OrgID;
      // Params.ParamValues['filter_EQL_sd!id'] := nvhelpschedule.Id;
      // Params.ParamValues['filter_EQL_v!id'] := nvhelpschedule.HelpFieldValue
      // ['vehicleid'];
      // Params.ParamValues['filter_EQL_vep!id'] := nvhelpschedule.HelpFieldValue
      // ['vehportid'];

      // Params.ParamValues['filter_EQL_ss!id'] := nvhelpschedule.HelpFieldValue
      // ['schstatusid'];

      { if (nvhelpvehiclecode.Text = '') or (nvhelpvehiclecode.Id <= 0) then
        begin
        drivername := '';
        vehunitname := '';
        end
        else
        begin
        Active := True;
        while not eof do
        begin
        drivername := FieldByName('drivername').AsString;
        vehunitname := FieldByName('unitname').AsString;
        Next;
        end;
        end; }


      // SysDialogs.ShowMessage(IntToStr(jcdsResult.DataSize));

      // if jcdsResult.DataSize < 1 then
      // begin
      // SysDialogs.ShowMessage('���������쳣�����ؽ����С��Ԥ����!');
      // exit;
      // end
      // else if jcdsResult.DataSize > 1 then
      // begin
      // SysDialogs.ShowMessage('���������쳣�����ؽ��������Ԥ����!');
      // exit;
      // end;

      printValue := TDictionary<String, String>.Create;
      billPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('�а�ǩ����', '�а�ǩ����'));
      printValue.Clear;
      multiplelists := TList < TDictionary < String, String >> .Create;
      // ǩ�����š��������ڡ���κš����ƺ��롢��ʻԱ��Ӫ�˵�λ���а��������ܽ�
      printValue.add('singbillno',
        Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill']); // ǩ������
      // ��������
      printValue.add('departdate', FormatDateTime('yyyy-MM-dd',
          dtpdepartdate.DateTime));

      // ����ʱ��
      printValue.add('departtime', '');
      // ���
      printValue.add('schedulevalue', '');
      // ���ƺ�
      printValue.add('vehiclevalue', '');
      // ��ʻԱ
      printValue.add('drivername', drivername);

      printValue.add('unitname', vehunitname); // Ӫ�˵�λ
      printValue.add('piecesnums', nvedtpieces.Text); // �а�����
      printValue.add('totalfeecountmoney', nvedttotalfee.Text); // �ܽ��
      printValue.add('sellbyname', Sysinfo.LoginUserInfo.UserName); // ǩ����
      printValue.add('printdate', FormatDateTime('yyyy-MM-dd HH:mm:ss', Now));
      // ǩ��ʱ��
      printValue.add('sendstation', Sysinfo.LoginUserInfo.ticketoutletsname);
      // ǩ��վ

      multipleValueValue := TDictionary<String, String>.Create;
      multipleValueValue.add('packno', packno); // ���˵���
      multipleValueValue.add('sender', nvedtsender.Text); // ������
      multipleValueValue.add('senderphone', nvedtsenderphone.Text); // �����˵绰
      multipleValueValue.add('tostationvalue', nvhelptostation.Text); // ��վ
      multipleValueValue.add('consignee', nvedtconsignee.Text); // �ջ���
      multipleValueValue.add('consigneephone', nvedtconsigneephone.Text);
      // �ջ��˵绰
      multipleValueValue.add('pieces', nvedtpieces.Text); // ����
      multipleValueValue.add('totalfeemoney', nvedttotalfee.Text); // �ϼƽ��
      multipleValueValue.add('shippricemoney', nvedtshipprice.Text); // ���˷�
      multipleValueValue.add('packfeemoney', nvedtpackfee.Text); // ��װ��
      multipleValueValue.add('handfeemoney', nvedthandfee.Text); // װж��
      multipleValueValue.add('deliveryfeemoney', nvedtdeliveryfee.Text);
      // �ͻ���
      multipleValueValue.add('transitfeemoney', nvedttransitfee.Text); // ��ת��
      multipleValueValue.add('insuredamountmoney', nvedtinsuredamount.Text);
      // ������ֵ
      multipleValueValue.add('insurancefeemoney', nvedtinsurancefee.Text);
      // ���۷�
      multipleValueValue.add('insurancemoney', ''); // ���շ�
      multipleValueValue.add('otherfeemoney', nvedtotherfee.Text); // ��������
      multipleValueValue.add('packpricemoney', nvedtpackprice.Text); // ���ջ���

      multiplelists.add(multipleValueValue);

      try
        log := '�а�����ǩ��������=' + Sysinfo.LoginUserInfo.orgname + ',ǩ��Ʊ��=' +
          Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill']
          + ',ǩ����=' + Sysinfo.LoginUserInfo.UserName + ',�а�����=' +
          nvedtpieces.Text + ',�ܽ��=' + nvedttotalfee.Text + ',ǩ��ʱ��=' +
          FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ',���˵���=' + Trim
          (nvedtpackno.Text);

        SysLog.WriteLog('�а�����->�а����', '�а�ǩ��', log);

      finally

      end;

      if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackSgBill')
        and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackSgBill') and
        (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] > 0) then
      begin
        IssuePrintClink();
        IssueUpdatePackbill();
      end
      else
      begin
        exit;
      end;
    end;
  end;
end;

procedure TFrmPackacceptAdd.IssuePrintClink();
begin
  try

    billPrint.MultipleValue := multiplelists;

    billPrint.SingleValue := printValue;
    billPrint.Print;

  finally

  end;
end;

procedure TFrmPackacceptAdd.IssueUpdatePackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with Sysinfo.LoginUserInfo do
  begin

    billinusenextform := IntToStr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill']));
    billinusenextno := IntToStr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill'])
        + 1);

    curBillNo.AddOrSetValue('PackSgBill', zerofill(billinusenextno,
        length(curBillNo.Items['PackSgBill'])));
    curBillNum.AddOrSetValue('PackSgBill', curBillNum.Items['PackSgBill'] - 1);

    if curBillNum.Items['PackSgBill'] > 0 then
      billinusestatus := '1'
    else
      billinusestatus := '2';

  end;

  with jcdsupdateBillinuse do
  begin
    Active := false;
    Params.ParamValues['billinusestatus'] := billinusestatus;
    Params.ParamValues['billinusenextno'] := billinusenextno;
    Params.ParamValues['billinusenextform'] := billinusenextform;
    Params.ParamValues['billtypecode'] := 'PackSgBill';
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

procedure TFrmPackacceptAdd.computePayMoney();
var
  integral, availableIntegral, paymoney: double;
begin
  //
  paymoney := StrTofloat(Trim(nvedttotalfee.Text)) - StrTofloat
    (Trim(nvedtIntegrateMoney.Text));
  if paymoney < 0 then
  begin
    nvedtPayMoney.Text := '0';

    integral := Ceil(StrTofloat(Trim(nvedttotalfee.Text)) / percent);
    { availableIntegral:=StrToFloat(nvedtsendintegrater.Text);
      if availableIntegral < integral then
      begin
      nvedtintegrate.Text := FloatToStr(availableIntegral);
      nvedtIntegrateMoney.Text := FloatToStr
      (trunc(percent * availableIntegral * 100) / 100);
      end
      else
      begin
      nvedtintegrate.Text := FloatToStr(integral);
      nvedtIntegrateMoney.Text := FloatToStr
      (trunc(percent * integral * 100) / 100);
      end; }
    nvedtintegrate.Text := FloatToStr(integral);
    nvedtIntegrateMoney.Text := FloatToStr
      (trunc(percent * integral * 100) / 100);
  end
  else
  begin
    nvedtPayMoney.Text := FloatToStr(paymoney);
  end;
end;

procedure TFrmPackacceptAdd.dtpdepartdateChange(Sender: TObject);
begin
  inherited;
  if nvhelptostation.Id > 0 then
    with nvhelpschedule do
    begin
      Params.ParamValues['filter_EQD_tp!departdate'] := FormatDateTime
        ('yyyy-mm-dd', dtpdepartdate.DateTime);
      Params.ParamValues['filter_EQL_tp!reachstationid'] := nvhelptostation.Id;
      Params.ParamValues['filter_EQL_tp!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
    end;
end;

end.
