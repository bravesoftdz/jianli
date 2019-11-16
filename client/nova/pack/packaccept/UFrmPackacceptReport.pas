unit UFrmPackacceptReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaPrint,
  ImgList, DB, ADODB,
  DBClient, jsonClientDataSet, Generics.Collections;

type
  TFrmPackacceptReport = class(TSimpleEditForm)
    btn1: TButton;
    ds1: TDataSource;
    ds2: TDataSource;
    lbl1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    billPrint: TNovaPrint;
    notprintValue: TList<string>; // ����ӡ��Ŀ
    printValue: TDictionary<String, String>; // ���������
  public
    { Public declarations }
    WPath, startticketno, endticketno, saledate: string;
    sign: Boolean;
    ticketturnoverid: Int64;
    returntno, canceltno, damagedtno, returnino, cancelino, damagedino,
      templtename, turnoverid, remarks, orgname, turnovertime, receivername,
      sellername, sellercode: string;

    bookservicefee, changeservicefee, moneypayable, noncashmoney,
      nonvouchermoneypayable, returnhandcharge, returnmoney, sellmoney,
      servicefee, money, cancelmoney, stationservicefee: Currency;

    startmoneydate, endmoneydate: TDateTime;
    cancelnum, eticketnum, sellnum, noncashnum, returnnum, returnprintnum,
      billdamagednum, sellreturntripnum: Int64;

    insurecancelmoney, insurereturnmoney, insuresellmoney,
      insuremoneypayable: Currency;
    insurecancelnum, insurereturnnum, insuresellnum: Int64;

    packtype: string; // ;//varchar2(10)	y			�а����ͣ�0��������1������
    goodtype: string; // �������
    sendstationvalue: string; // number(10)	y			����վ
    tostationvalue: string; // number(10)	n			Ŀ�ĵ�
    name: string; // varchar2(50)	n			��������
    schedulevalue: string; // number(10)	y			���
    vehiclevalue: string; // number(10)	n			���ƺ�
    departdate: string; // date	;//date	y			��������������
    packno: string; // varchar2(20)	y			�а�����
    invoiceno: string; // varchar2(20)	y			��Ʊ��
    sellbyname: string; // number(10)	y			����Ա
    pieces: string; // number(3)	y			����
    weight: string; // number(3)	y			����
    volume: string; // varchar2(20)	y			���
    packaed: string; // varchar2(10)	y			��װ��ֽ�䡢���ϴ����ޣ�
    shippricemoney: string; // number(6,2)	y			���˷�
    packfeemoney: string; // number(6,2)	y			��װ��
    handfeemoney: string; // number(6,2)	y			װж��
    deliveryfeemoney: string; // �ͻ���
    custodialmoney: string; // number(6,2)	y			���ܷ�
    transitfeemoney: string; // number(6,2)	y			��ת��
    insuredamountmoney: string; // number(6,2)	y			���۽��
    insurancefeemoney: string; // number(6,2)	y			���۷�
    insurancemoney: string; // number(6,2)	y			���շ�
    otherfeemoney: string; // number(6,2)	y			��������
    totalfeemoney: string; // number(6,2)	y			�ϼƽ��
    location: string; // varchar2(20)	y			���λ��
    packpricemoney: string; // number(6,2)	y			���ջ���
    servicefeemoney: string; // number(6,2)	y			�����
    integraterprice: string;// ���ֵֿ۽��
    totalprice: string; // ���ջ���+�ϼƽ��-���ֵֿ۽��
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
    remaks: string; // varchar2(50)	y			��ע
    orgid: Integer; // number(10)	y
    createtime: TDateTime; // date	n	sys;//date
    createby: Integer; // number(10)	n
    updatetime: TDateTime; // date	n	sys;//date
    updateby: Integer; // number(10)	n

    selltime: string; // ����ʱ��
         // ����ʱ��
  departtime:string;
    procedure ShowReport;
    procedure PrintPackReport;
    procedure PrintPackInvoiceReport;
  end;

var
  FrmPackacceptReport: TFrmPackacceptReport;

implementation

uses Services;
{$R *.dfm}

procedure TFrmPackacceptReport.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  { frxrprt1.LoadFromFile(WPath + 'Ticketturnover.fr3');
    frxrprt1.Script.AddVariable('WPath', 'String', WPath);
    frxrprt1.DesignReport; }
end;

procedure TFrmPackacceptReport.btn1Click(Sender: TObject);
begin
  inherited;
  ShowReport;
end;

procedure TFrmPackacceptReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(printValue) then
    printValue.Free;
end;

procedure TFrmPackacceptReport.FormShow(Sender: TObject);
begin
  inherited;
  WPath := ExtractFilePath(Application.ExeName);
end;

procedure TFrmPackacceptReport.ShowReport;
begin

end;

procedure TFrmPackacceptReport.PrintPackReport();
begin

  Delete(turnoverid, Length(turnoverid), 1);

  templtename := TNovaPrint.GetTicketModelName('�а�����', '�а�����');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  printValue.Add('goodtype', goodtype); // �������
  printValue.Add('sendstationvalue', sendstationvalue); // ����վ
  printValue.Add('tostationvalue', tostationvalue); // Ŀ�ĵ�
  printValue.Add('goodname', name); // ��������
  printValue.Add('schedulevalue', schedulevalue); // ���
  printValue.Add('vehiclevalue', vehiclevalue); // ���ƺ�
  printValue.Add('departdate', departdate); // ��������������
      // ����ʱ��
  printValue.Add('departtime', departtime);
  printValue.Add('packno', packno); // �а�����
  printValue.Add('invoiceno', invoiceno); // ��Ʊ��
  printValue.Add('sellbyname', sellbyname); // ������
  printValue.Add('pieces', pieces); // ����
  printValue.Add('weight', weight); // ����
  printValue.Add('volume', volume); // ���
  printValue.Add('packaed', packaed); // ��װ��ֽ�䡢���ϴ����ޣ�
  printValue.Add('shippricemoney', shippricemoney); // ���˷�
  printValue.Add('packfeemoney', packfeemoney); // ��װ��
  printValue.Add('handfeemoney', handfeemoney); // װж��
  printValue.Add('deliveryfeemoney', deliveryfeemoney); // �ͻ���
  // printValue.Add('custodialmoney', custodialmoney);//���ܷ�
  printValue.Add('transitfeemoney', transitfeemoney); // ��ת��
  printValue.Add('insuredamountmoney', insuredamountmoney); // ���۽��
  printValue.Add('insurancefeemoney', insurancefeemoney); // ���۷�
  printValue.Add('insurancemoney', insurancemoney); // ���շ�
  printValue.Add('otherfeemoney', otherfeemoney); // ��������
  printValue.Add('totalfeemoney', totalfeemoney); // �ϼƽ��
  // printValue.Add('location', location);//���λ��
  printValue.Add('packpricemoney', packpricemoney); // ���ջ���
  printValue.Add('sender', Sender); // ������
  printValue.Add('selltime', selltime); // ������
  printValue.Add('senderphone', senderphone); // �����˵绰
  printValue.Add('senderaddress', senderaddress); // �����˵�ַ
  printValue.Add('consignee', consignee); // �ջ���
  printValue.Add('consigneephone', consigneephone); // �ջ��˵绰
  printValue.Add('consigneeaddress', consigneeaddress); // �ջ��˵�ַ
  printValue.Add('certificatetype', certificatetype);
  // ֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
  printValue.Add('certificateno', certificateno); // ֤������
  printValue.Add('shiptype', shiptype); // ���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
  printValue.Add('paymethod', paymethod); // ���ʽ���ָ����Ḷ��ȡ�����ֵ�
  printValue.Add('valuables', valuables); // �Ƿ������Ʒ
  printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now())); // ��ӡʱ��
  printValue.Add('remarks', remarks); // ��������
  printValue.Add('totalprice', totalprice); // ���ջ���+�ϼƽ��
  printValue.Add('servicefeemoney', servicefeemoney); // �����
  printValue.Add('integraterprice', integraterprice); // ���ֵֿ۽��
  printValue.Add('unpackfee',FloatToStr(strtofloat(totalfeemoney)+strtofloat(totalprice)- strtofloat(packfeemoney))); // �����
  billPrint.SingleValue := printValue;
  billPrint.Print;

end;

procedure TFrmPackacceptReport.PrintPackInvoiceReport();
begin

  Delete(turnoverid, Length(turnoverid), 1);

  templtename := TNovaPrint.GetTicketModelName('�а�����', '�а���Ʊ��');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  printValue.Add('goodtype', goodtype); // �������
  printValue.Add('sendstationvalue', sendstationvalue); // ����վ
  printValue.Add('tostationvalue', tostationvalue); // Ŀ�ĵ�
  printValue.Add('goodname', name); // ��������
  printValue.Add('schedulevalue', schedulevalue); // ���
  printValue.Add('vehiclevalue', vehiclevalue); // ���ƺ�
  printValue.Add('departdate', departdate); // ��������������
  printValue.Add('packno', packno); // �а�����
  printValue.Add('invoiceno', invoiceno); // ��Ʊ��
  printValue.Add('sellbyname', sellbyname); // ������
  printValue.Add('pieces', pieces); // ����
  printValue.Add('weight', weight); // ����
  printValue.Add('volume', volume); // ���
  printValue.Add('packaed', packaed); // ��װ��ֽ�䡢���ϴ����ޣ�
  printValue.Add('shippricemoney', shippricemoney); // ���˷�
  printValue.Add('packfeemoney', packfeemoney); // ��װ��
  printValue.Add('handfeemoney', handfeemoney); // װж��
  printValue.Add('deliveryfeemoney', deliveryfeemoney); // �ͻ���
  // printValue.Add('custodialmoney', custodialmoney);//���ܷ�
  printValue.Add('transitfeemoney', transitfeemoney); // ��ת��
  printValue.Add('servicefeemoney', servicefeemoney); // �����
  printValue.Add('insuredamountmoney', insuredamountmoney); // ���۽��
  printValue.Add('insurancefeemoney', insurancefeemoney); // ���۷�
  printValue.Add('insurancemoney', insurancemoney); // ���շ�
  printValue.Add('otherfeemoney', otherfeemoney); // ��������
  printValue.Add('totalfeemoney', totalfeemoney); // �ϼƽ��
  // printValue.Add('location', location);//���λ��
  printValue.Add('packpricemoney', packpricemoney); // ���ջ���
  printValue.Add('sender', Sender); // ������
  printValue.Add('senderphone', senderphone); // �����˵绰
  printValue.Add('senderaddress', senderaddress); // �����˵�ַ
  printValue.Add('consignee', consignee); // �ջ���
  printValue.Add('consigneephone', consigneephone); // �ջ��˵绰
  printValue.Add('consigneeaddress', consigneeaddress); // �ջ��˵�ַ
  printValue.Add('certificatetype', certificatetype);
  // ֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
  printValue.Add('certificateno', certificateno); // ֤������
  printValue.Add('shiptype', shiptype); // ���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
  printValue.Add('paymethod', paymethod); // ���ʽ���ָ����Ḷ��ȡ�����ֵ�
  printValue.Add('valuables', valuables); // �Ƿ������Ʒ
  printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now())); // ��ӡʱ��
  printValue.Add('remarks', remarks); // ��������

  billPrint.SingleValue := printValue;
  billPrint.Print;

end;

end.
