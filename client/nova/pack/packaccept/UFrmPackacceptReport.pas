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
    notprintValue: TList<string>; // 不打印项目
    printValue: TDictionary<String, String>; // 输出单变量
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

    packtype: string; // ;//varchar2(10)	y			行包类型（0：发货，1：到货
    goodtype: string; // 货物类别
    sendstationvalue: string; // number(10)	y			发货站
    tostationvalue: string; // number(10)	n			目的地
    name: string; // varchar2(50)	n			货物名称
    schedulevalue: string; // number(10)	y			班次
    vehiclevalue: string; // number(10)	n			车牌号
    departdate: string; // date	;//date	y			发货、到货日期
    packno: string; // varchar2(20)	y			行包单号
    invoiceno: string; // varchar2(20)	y			发票号
    sellbyname: string; // number(10)	y			办理员
    pieces: string; // number(3)	y			件数
    weight: string; // number(3)	y			重量
    volume: string; // varchar2(20)	y			体积
    packaed: string; // varchar2(10)	y			包装（纸箱、塑料袋、无）
    shippricemoney: string; // number(6,2)	y			托运费
    packfeemoney: string; // number(6,2)	y			包装费
    handfeemoney: string; // number(6,2)	y			装卸费
    deliveryfeemoney: string; // 送货费
    custodialmoney: string; // number(6,2)	y			保管费
    transitfeemoney: string; // number(6,2)	y			中转费
    insuredamountmoney: string; // number(6,2)	y			保价金额
    insurancefeemoney: string; // number(6,2)	y			保价费
    insurancemoney: string; // number(6,2)	y			保险费
    otherfeemoney: string; // number(6,2)	y			其他费用
    totalfeemoney: string; // number(6,2)	y			合计金额
    location: string; // varchar2(20)	y			存放位置
    packpricemoney: string; // number(6,2)	y			代收货款
    servicefeemoney: string; // number(6,2)	y			服务费
    integraterprice: string;// 积分抵扣金额
    totalprice: string; // 代收货款+合计金额-积分抵扣金额
    Sender: string; // varchar2(30)	y			托运人
    senderphone: string; // varchar2(20)	y			托运人电话
    senderaddress: string; // varchar2(100)	y			托运人地址
    consignee: string; // varchar2(30)	y			收货人
    consigneephone: string; // varchar2(20)	y			收货人电话
    consigneeaddress: string; // varchar2(100)	y			收货人地址
    certificatetype: string; // varchar2(10)	y			证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
    certificateno: string; // varchar2(30)	y			证件号码
    shiptype: string; // varchar2(10)	y			托运方式（随车自提、收获人提领）取数据字典
    paymethod: string; // varchar2(10)	y			付款方式（现付、提付）取数据字典
    valuables: string; // number(1)	y			是否贵重物品
    status: string; // varchar2(10)	y			状态(0：库存、1：签发、2：提领、3：作废)
    packtturnoverid: string; // number(10)	y			缴款id
    remaks: string; // varchar2(50)	y			备注
    orgid: Integer; // number(10)	y
    createtime: TDateTime; // date	n	sys;//date
    createby: Integer; // number(10)	n
    updatetime: TDateTime; // date	n	sys;//date
    updateby: Integer; // number(10)	n

    selltime: string; // 受理时间
         // 发车时间
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

  templtename := TNovaPrint.GetTicketModelName('行包受理单', '行包受理单');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  printValue.Add('goodtype', goodtype); // 货物类别
  printValue.Add('sendstationvalue', sendstationvalue); // 发货站
  printValue.Add('tostationvalue', tostationvalue); // 目的地
  printValue.Add('goodname', name); // 货物名称
  printValue.Add('schedulevalue', schedulevalue); // 班次
  printValue.Add('vehiclevalue', vehiclevalue); // 车牌号
  printValue.Add('departdate', departdate); // 发货、到货日期
      // 发车时间
  printValue.Add('departtime', departtime);
  printValue.Add('packno', packno); // 行包单号
  printValue.Add('invoiceno', invoiceno); // 发票号
  printValue.Add('sellbyname', sellbyname); // 受理人
  printValue.Add('pieces', pieces); // 件数
  printValue.Add('weight', weight); // 重量
  printValue.Add('volume', volume); // 体积
  printValue.Add('packaed', packaed); // 包装（纸箱、塑料袋、无）
  printValue.Add('shippricemoney', shippricemoney); // 托运费
  printValue.Add('packfeemoney', packfeemoney); // 包装费
  printValue.Add('handfeemoney', handfeemoney); // 装卸费
  printValue.Add('deliveryfeemoney', deliveryfeemoney); // 送货费
  // printValue.Add('custodialmoney', custodialmoney);//保管费
  printValue.Add('transitfeemoney', transitfeemoney); // 中转费
  printValue.Add('insuredamountmoney', insuredamountmoney); // 保价金额
  printValue.Add('insurancefeemoney', insurancefeemoney); // 保价费
  printValue.Add('insurancemoney', insurancemoney); // 保险费
  printValue.Add('otherfeemoney', otherfeemoney); // 其他费用
  printValue.Add('totalfeemoney', totalfeemoney); // 合计金额
  // printValue.Add('location', location);//存放位置
  printValue.Add('packpricemoney', packpricemoney); // 代收货款
  printValue.Add('sender', Sender); // 托运人
  printValue.Add('selltime', selltime); // 托运人
  printValue.Add('senderphone', senderphone); // 托运人电话
  printValue.Add('senderaddress', senderaddress); // 托运人地址
  printValue.Add('consignee', consignee); // 收货人
  printValue.Add('consigneephone', consigneephone); // 收货人电话
  printValue.Add('consigneeaddress', consigneeaddress); // 收货人地址
  printValue.Add('certificatetype', certificatetype);
  // 证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
  printValue.Add('certificateno', certificateno); // 证件号码
  printValue.Add('shiptype', shiptype); // 托运方式（随车自提、收获人提领）取数据字典
  printValue.Add('paymethod', paymethod); // 付款方式（现付、提付）取数据字典
  printValue.Add('valuables', valuables); // 是否贵重物品
  printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now())); // 打印时间
  printValue.Add('remarks', remarks); // 货物描述
  printValue.Add('totalprice', totalprice); // 代收货款+合计金额
  printValue.Add('servicefeemoney', servicefeemoney); // 服务费
  printValue.Add('integraterprice', integraterprice); // 积分抵扣金额
  printValue.Add('unpackfee',FloatToStr(strtofloat(totalfeemoney)+strtofloat(totalprice)- strtofloat(packfeemoney))); // 服务费
  billPrint.SingleValue := printValue;
  billPrint.Print;

end;

procedure TFrmPackacceptReport.PrintPackInvoiceReport();
begin

  Delete(turnoverid, Length(turnoverid), 1);

  templtename := TNovaPrint.GetTicketModelName('行包受理单', '行包发票单');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  printValue.Add('goodtype', goodtype); // 货物类别
  printValue.Add('sendstationvalue', sendstationvalue); // 发货站
  printValue.Add('tostationvalue', tostationvalue); // 目的地
  printValue.Add('goodname', name); // 货物名称
  printValue.Add('schedulevalue', schedulevalue); // 班次
  printValue.Add('vehiclevalue', vehiclevalue); // 车牌号
  printValue.Add('departdate', departdate); // 发货、到货日期
  printValue.Add('packno', packno); // 行包单号
  printValue.Add('invoiceno', invoiceno); // 发票号
  printValue.Add('sellbyname', sellbyname); // 受理人
  printValue.Add('pieces', pieces); // 件数
  printValue.Add('weight', weight); // 重量
  printValue.Add('volume', volume); // 体积
  printValue.Add('packaed', packaed); // 包装（纸箱、塑料袋、无）
  printValue.Add('shippricemoney', shippricemoney); // 托运费
  printValue.Add('packfeemoney', packfeemoney); // 包装费
  printValue.Add('handfeemoney', handfeemoney); // 装卸费
  printValue.Add('deliveryfeemoney', deliveryfeemoney); // 送货费
  // printValue.Add('custodialmoney', custodialmoney);//保管费
  printValue.Add('transitfeemoney', transitfeemoney); // 中转费
  printValue.Add('servicefeemoney', servicefeemoney); // 服务费
  printValue.Add('insuredamountmoney', insuredamountmoney); // 保价金额
  printValue.Add('insurancefeemoney', insurancefeemoney); // 保价费
  printValue.Add('insurancemoney', insurancemoney); // 保险费
  printValue.Add('otherfeemoney', otherfeemoney); // 其他费用
  printValue.Add('totalfeemoney', totalfeemoney); // 合计金额
  // printValue.Add('location', location);//存放位置
  printValue.Add('packpricemoney', packpricemoney); // 代收货款
  printValue.Add('sender', Sender); // 托运人
  printValue.Add('senderphone', senderphone); // 托运人电话
  printValue.Add('senderaddress', senderaddress); // 托运人地址
  printValue.Add('consignee', consignee); // 收货人
  printValue.Add('consigneephone', consigneephone); // 收货人电话
  printValue.Add('consigneeaddress', consigneeaddress); // 收货人地址
  printValue.Add('certificatetype', certificatetype);
  // 证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
  printValue.Add('certificateno', certificateno); // 证件号码
  printValue.Add('shiptype', shiptype); // 托运方式（随车自提、收获人提领）取数据字典
  printValue.Add('paymethod', paymethod); // 付款方式（现付、提付）取数据字典
  printValue.Add('valuables', valuables); // 是否贵重物品
  printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now())); // 打印时间
  printValue.Add('remarks', remarks); // 货物描述

  billPrint.SingleValue := printValue;
  billPrint.Print;

end;

end.
