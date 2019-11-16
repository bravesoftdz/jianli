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
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelists: TList < TDictionary < String, String >> ; // 输出数据集
    multipleValueValue: TDictionary<String, String>;
    isdrawbill: string; // 是否需要领用托运单票证
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
    packtype: string; // ;//varchar2(10)	y			行包类型（0：发货，1：到货
    goodtype: string; // 货物类别
    sendstationid: Integer; // number(10)	y			发货站
    tostationid: Integer; // number(10)	n			目的地
    name: string; // varchar2(50)	n			货物名称
    scheduleid: Integer; // number(10)	y			班次
    vehicleid: Integer; // number(10)	n			车牌号
    depart: TDateTime; // date	;//date	y			发货、到货日期
    packno: string; // varchar2(20)	y			行包单号
    invoiceno: string; // varchar2(20)	y			发票号
    sellby: Integer; // number(10)	y			办理员
    sellbyname: string;
    pieces: Integer; // number(3)	y			件数
    weight: double; // number(3)	y			重量
    volume: string; // varchar2(20)	y			体积
    packaed: string; // varchar2(10)	y			包装（纸箱、塑料袋、无）
    shipprice: double; // number(6,2)	y			托运费
    packfee: double; // number(6,2)	y			包装费
    handfee: double; // number(6,2)	y			装卸费
    deliveryfee: double; // 送货费
    custodial: double; // number(6,2)	y			保管费
    transitfee: double; // number(6,2)	y			中转费
    insuredamount: double; // number(6,2)	y			保价金额
    insurancefee: double; // number(6,2)	y			保价费
    insurance: double; // number(6,2)	y			保险费
    otherfee: double; // number(6,2)	y			其他费用
    totalfee: double; // number(6,2)	y			合计金额
    location: string; // varchar2(20)	y			存放位置
    packprice: double; // number(6,2)	y			代收货款
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
    remak: string; // varchar2(50)	y			备注
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
    insurancevalue, insurancefeevalue: double; // 保险费报价费比率
    insuranceboolean, insurancefeeboolean: Integer; // 保险费报价费是否参与计费
    isprintInvoice: string; // 行包受理是否打印发票  0不打印 1打印
    departtime: string;
    distance: Integer; // 公里数
    flag: boolean; // 是否是修改
    isinputpacked: boolean; // 包装类别是否为输入

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
    SysDialogs.ShowMessage('单号不能为空!');
    nvedtpackno.SetFocus;
    exit;
  end;

  if nvhelptostation.Id <= 0 then
  begin
    SysDialogs.ShowMessage('目的地不能为空!');
    nvhelptostation.SetFocus;
    exit;
  end;

  { if Trim(nvedtname.Text) = '' then
    begin
    SysDialogs.ShowMessage('货物名称不能为空!');
    nvedtname.SetFocus;
    exit;
    end; }

  if nvcbbgoodname.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择货物名称！');
    nvcbbgoodname.SetFocus;
    exit;
  end;

  if StrToInt(FormatDateTime('yyyyMMdd', dtpdepartdate.DateTime)) < StrToInt
    (FormatDateTime('yyyyMMdd', Now())) then
  begin
    SysDialogs.ShowMessage('发货日期不能小于今天!');
    dtpdepartdate.SetFocus;
    exit;
  end;

  if nvcbbpacked.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择包装类型!');
    nvcbbpacked.SetFocus;
    exit;
  end;

  if (Trim(nvedtpieces.Text) = '') then
  begin
    SysDialogs.ShowMessage('件数不能为空!');
    nvedtpieces.Text := '1';
    nvedtpieces.SetFocus;
    exit;
  end;

  if Trim(nvedtweight.Text) = '' then
  begin
    SysDialogs.ShowMessage('重量不能为空!');
    nvedtweight.Text := '1';
    nvedtweight.SetFocus;
    exit;
  end;

  { if Trim(nvedtvolume.Text) = '' then
    begin
    SysDialogs.ShowMessage('体积不能为空!');
    nvedtvolume.Text := '1';
    nvedtvolume.SetFocus;
    exit;
    end; }

  if Trim(nvedtsender.Text) = '' then
  begin
    SysDialogs.ShowMessage('托运人不能为空!');
    nvedtsender.SetFocus;
    exit;
  end;

  if Trim(nvedtsenderphone.Text) = '' then
  begin
    SysDialogs.ShowMessage('托运人联系电话不能为空!');
    nvedtsenderphone.SetFocus;
    exit;
  end;

  if Trim(nvedtconsignee.Text) = '' then
  begin
    SysDialogs.ShowMessage('收货人不能为空!');
    nvedtconsignee.SetFocus;
    exit;
  end;

  if Trim(nvedtconsigneephone.Text) = '' then
  begin
    SysDialogs.ShowMessage('收货人联系电话不能为空!');
    nvedtconsigneephone.SetFocus;
    exit;
  end;

  //收货人证件号
//  if (Trim(nvedtcertificateno.Text) = '') then
//  begin
//     SysDialogs.ShowMessage('收货人证件号不能为空!');
//     nvedtcertificateno.SetFocus;
//     exit;
//    if nvcbbcertificatetype.ItemIndex < 0 then
//    begin
//      SysDialogs.ShowMessage('请选择证件类型!');
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
    SysDialogs.ShowMessage('请选择提货方式!');
    nvcbbshiptype.SetFocus;
    exit;
  end;

  if nvcbbpaymethod.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择付款方式!');
    nvcbbpaymethod.SetFocus;
    exit;
  end;

  if (Trim(nvedtshipprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('托运费不能为空!');
    nvedtshipprice.SetFocus;
    exit;
  end;

  if (Trim(nvedtinsuredamount.Text) = '') then
  begin
    SysDialogs.ShowMessage('声明价值不能为空!');
    nvedtinsuredamount.Text := '0';
    nvedtinsuredamount.SetFocus;
    exit;
  end;

  if (Trim(nvedtinsurancefee.Text) = '') then
  begin
    SysDialogs.ShowMessage('保价费不能为空!');
    nvedtinsurancefee.Text := '0';
    nvedtinsurancefee.SetFocus;
    exit;
  end;

  if (Trim(nvedtpackfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('包装费不能为空!');
    nvedtpackfee.Text := '0';
    nvedtpackfee.SetFocus;
    exit;
  end;

  if (Trim(nvedthandfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('装卸费不能为空!');
    nvedthandfee.Text := '0';
    nvedthandfee.SetFocus;
    exit;
  end;

  if (Trim(nvedttransitfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('中转费不能为空!');
    nvedttransitfee.Text := '0';
    nvedttransitfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtdeliveryfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('送货费不能为空!');
    nvedtdeliveryfee.Text := '0';
    nvedtdeliveryfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtotherfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('其他费用不能为空!');
    nvedtotherfee.Text := '0';
    nvedtotherfee.SetFocus;
    exit;
  end;

  if (Trim(nvedttotalfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('合计金额不能为空!');
    nvedttotalfee.Text := '0';
    nvedttotalfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtpackprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('代收货款不能为空!');
    nvedtpackprice.Text := '0';
    nvedtpackprice.SetFocus;
    exit;
  end
  else
  begin
    if (nvcbbpaymethod.ItemIndex = 1) and
      (StrTofloat(Trim(nvedtpackprice.Text)) <= 0) then
    begin
      SysDialogs.ShowMessage('付款方式为对付，代收货款不能为0!');
      nvedtpackprice.Text := '0';
      nvedtpackprice.SetFocus;
      exit;
    end;
  end;

  if StrTofloat(nvedtshipprice.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('托运费金额数值超出范围(0~9999.99)!');
    nvedtshipprice.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtinsuredamount.Text) >= 1000000 then
  begin
    SysDialogs.ShowMessage('声明价值金额数值超出范围(0~999999.99)!');
    nvedtinsuredamount.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtinsurancefee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('保价费金额数值超出范围(0~9999.99)!');
    nvedtinsurancefee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtpackfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('包装费金额数值过大(0~9999.99)!');
    nvedtpackfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedthandfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('装卸费金额数值超出范围(0~9999.99)!');
    nvedthandfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedttransitfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('中转费金额数值超出范围(0~9999.99)!');
    nvedttransitfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtdeliveryfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('送货费金额数值超出范围(0~9999.99)!');
    nvedtdeliveryfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtotherfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('其他费用金额数值超出范围(0~9999.99)!');
    nvedtotherfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedttotalfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  if StrTofloat(nvedtpackprice.Text) >= 1000000 then
  begin
    SysDialogs.ShowMessage('代收货款金额数值超出范围(0~999999.99)!');
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

    // packtype:string;//	;//varchar2(10)	y			行包类型（0：发货，1：到货
    Params.ParamByName('pack.packtype').Value := '0';

    // goodtype:string;//货物类别
    Params.ParamByName('pack.goodtype').Value := 0;
    // sendstationid:Integer;//number(10)	y			发货站
    Params.ParamByName('pack.sendstationid').Value :=
      Sysinfo.LoginUserInfo.StationID;
    // tostationid:Integer;//number(10)	n			目的地
    Params.ParamByName('pack.tostationid').Value := IntToStr
      (nvhelptostation.Id);
    // name:string;//varchar2(50)	n			货物名称
    Params.ParamByName('pack.name').Value := nvcbbgoodname.Text;
    // scheduleid:Integer;//number(10)	y			班次
    Params.ParamByName('pack.scheduleid').Value := nvhelpschedule.Id;
    packstatus := '0'; // 库存

    // depart:TDateTime;//date	;//date	y			发货、到货日期
    Params.ParamByName('pack.departdate').Value := FormatDateTime('yyyy-mm-dd',
      dtpdepartdate.DateTime);
    // packno:string;//varchar2(20)	y			行包单号
    Params.ParamByName('pack.packno').Value := packno;
    // invoiceno:string;//varchar2(20)	y			发票号
    Params.ParamByName('pack.invoiceno').Value := invoiceno;

    // sellby:Integer;//number(10)	y			办理员
    Params.ParamByName('pack.sellby').Value := IntToStr(sellby);

    Params.ParamByName('pack.collectby').Value := IntToStr(sellby); // 代收人  代收日期
    Params.ParamByName('pack.collectdate').Value := FormatDateTime
      ('yyyy-mm-dd', Now());

    // pieces:Integer;//number(3)	y			件数
    Params.ParamByName('pack.pieces').Value := Trim(nvedtpieces.Text);
    // weight:Integer;//number(3)	y			重
    Params.ParamByName('pack.weight').Value := Trim(nvedtweight.Text);
    // volume:string;//varchar2(20)	y			体积
    Params.ParamByName('pack.volume').Value := '0';
    if isinputpacked then
    begin
      Params.ParamByName('pack.packed').Value := packaed; // 手动输入包装类别
    end
    else
    begin
      // packaed:Double;//varchar2(10)	y			包装（纸箱、塑料袋、无）
      Params.ParamByName('pack.packed').Value := nvcbbpacked.GetSelectCode;
    end;
    // shipprice:Double;//number(6,2)	y			托运费
    Params.ParamByName('pack.shipprice').Value := Trim(nvedtshipprice.Text);
    // packfee:Double;//number(6,2)	y			包装费
    Params.ParamByName('pack.packfee').Value := Trim(nvedtpackfee.Text);
    // handfee:Double;//number(6,2)	y			装卸费
    Params.ParamByName('pack.handfee').Value := Trim(nvedthandfee.Text);
    // deliveryfee:Double;//                         送货费
    Params.ParamByName('pack.deliveryfee').Value := Trim(nvedtdeliveryfee.Text);
    // custodial:Double;//number(6,2)	y			保管费
    Params.ParamByName('pack.custodial').Value := '0';
    // transitfee:Double;//number(6,2)	y			中转费
    Params.ParamByName('pack.transitfee').Value := Trim(nvedttransitfee.Text);
    // insuredamount:Double;//number(6,2)	y			保价金额
    Params.ParamByName('pack.insuredamount').Value := Trim
      (nvedtinsuredamount.Text);
    // insurancefee:Double;//number(6,2)	y			保价费
    Params.ParamByName('pack.insurancefee').Value := Trim
      (nvedtinsurancefee.Text);
    // insurance:Double;//number(6,2)	y			保险费
    Params.ParamByName('pack.insurance').Value := '0';
    // otherfee:Double;//number(6,2)	y			其他费用
    Params.ParamByName('pack.otherfee').Value := Trim(nvedtotherfee.Text);
    // otherfee:Double;//number(6,2)	y			服务费
    Params.ParamByName('pack.servicefee').Value := Trim(nvedtservicefee.Text);
    // totalfee:Double;//number(6,2)	y			合计金额
    Params.ParamByName('pack.totalfee').Value := Trim(nvedttotalfee.Text);
    // 抵扣积分金额
    Params.ParamByName('pack.integraterprice').Value := Trim
      (nvedtIntegrateMoney.Text);
    // location:string;//varchar2(20)	y			存放位置
    // packprice:Double;//number(6,2)	y			代收货款
    Params.ParamByName('pack.packprice').Value := Trim(nvedtpackprice.Text);
    // sender:string;//varchar2(30)	y			托运人
    Params.ParamByName('pack.sender').Value := Trim(nvedtsender.Text);
    // senderphone:string;//varchar2(20)	y			托运人电话
    Params.ParamByName('pack.senderphone').Value := Trim(nvedtsenderphone.Text);
    // senderaddress:string;//varchar2(100)	y			托运人地址
    Params.ParamByName('pack.senderaddress').Value := Trim
      (nvedtsenderaddress.Text);
    // consignee:string;//varchar2(30)	y			收货人
    Params.ParamByName('pack.consignee').Value := Trim(nvedtconsignee.Text);
    // consigneephone:string;//varchar2(20)	y			收货人电话
    Params.ParamByName('pack.consigneephone').Value := Trim
      (nvedtconsigneephone.Text);
    // consigneeaddress:string;//varchar2(100)	y			收货人地址
    Params.ParamByName('pack.consigneeaddress').Value := Trim
      (nvedtconsigneeaddress.Text);

    // certificatetype:string;//varchar2(10)	y			证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
    if (nvcbbcertificatetype.ItemIndex >= 0) then
      Params.ParamByName('pack.certificatetype').Value :=
        nvcbbcertificatetype.GetSelectCode
    else
      Params.ParamByName('pack.certificatetype').Value := '-1';

    // certificateno:string;//varchar2(30)	y			证件号码
    if (Trim(nvedtcertificateno.Text)='') then
         Params.ParamByName('pack.certificateno').Value := '无'
    else
        Params.ParamByName('pack.certificateno').Value := Trim
          (nvedtcertificateno.Text);

    // shiptype:string;//varchar2(10)	y			托运方式（随车自提、收获人提领）取数据字典
    Params.ParamByName('pack.shiptype').Value := nvcbbshiptype.GetSelectCode;
    // paymethod:string;//varchar2(10)	y			付款方式（现付、提付）取数据字典
    Params.ParamByName('pack.paymethod').Value := nvcbbpaymethod.GetSelectCode;

    if (nvcbbpaymethod.GetSelectCode = '1') then
    begin
      Params.ParamByName('pack.collectstatus').Value := '1'; // 已代付
      Params.ParamByName('pack.recyclestatus').Value := '0'; // 代付货款回收状态
    end
    else
    begin
      Params.ParamByName('pack.collectstatus').Value := '0'; // 未代付
    end;

    // valuables:string;//number(1)	y			是否贵重物品
    if rbvaluablesno.checked then
      Params.ParamByName('pack.valuables').Value := false
    else
      Params.ParamByName('pack.valuables').Value := True;

    // status:string;//varchar2(10)	y			状态(0：库存、1：签发、2：提领、3：作废)
    Params.ParamByName('pack.status').Value := packstatus;
    // orgid:Integer;//number(10)	y
    Params.ParamByName('pack.orgid').Value := IntToStr(orgid);
    // packtturnoverid:string;//number(10)	y			缴款id
    // remak:string;//varchar2(50)	y			备注
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

    // ===============积分消费流水信息====================
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
        result := '修改'

      else
      begin
        result := '添加';
      end;

      log := result + VarToStr(Params.ParamValues['packid'])
        + '行包受理：所属机构=' + orgname + ',' + result + '人=' +
        Sysinfo.LoginUserInfo.UserName + ',行包单号=' + packno + ',发票号=' +
        invoiceno + ',班次=' + schedulename + ',车牌号=' + vehiclecodename +
        ',目的地=' + nvhelptostation.Value + ',货物名称=' +
        nvcbbgoodname.Text + ',货物类别=0,包装类型=' + nvcbbpacked.Text + ',件数=' +
        nvedtpieces.Text + ',重量=' + nvedtweight.Text + ',托运人=' +
        nvedtsender.Text + ',托运人联系电话=' + nvedtsenderphone.Text + ',收货人=' +
        nvedtconsignee.Text + ',收货人联系电话=' + nvedtconsigneephone.Text +
        ',证件类型=' + nvcbbcertificatetype.Text + ',收货人证件号码=' +
        nvedtcertificateno.Text + ',提货方式=' + nvcbbshiptype.Text + ',付款方式=' +
        nvcbbpaymethod.Text + ',托运费=' + nvedtshipprice.Text + ',声明价值=' +
        nvedtinsuredamount.Text + ',保价费=' + nvedtinsurancefee.Text + ',包装费=' +
        nvedtpackfee.Text + ',装卸费=' + nvedthandfee.Text + ',中转费=' +
        nvedttransitfee.Text + ',送货费=' + nvedtdeliveryfee.Text + ',其他费用=' +
        nvedtotherfee.Text + ',合计金额=' + nvedttotalfee.Text + ',代收货款=' +
        nvedtpackprice.Text + ',状态=' + packstatus;
      SysLog.WriteLog('行包管理->行包受理', result, log);

      try
        Foperationid := Params.ParamValues['packid'];
        if getParametervalue('8016', Sysinfo.LoginUserInfo.orgid) = '1' then
        begin
          // 是否打印受理单
          if self.edittype = Tedittype.add then
          begin
            printpack;
          end;
        end;

        if packstatus = '1' then
        begin
          // 签发 打印签发单
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
    // 声明价值
    if StrTofloat(nvedtinsuredamount.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('保价金额数值超出范围(0~999999.99)!');
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
        (Ceil(StrTofloat(nvedtinsuredamount.Text) * insurancefeevalue));  // 金额向上取整方式
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
             //新包装方式
      if str2 <> '' then
      with jcdspacktypesave do
      begin
        Params.ParamValues['newPackType'] := str2;
        Execute;
      end;
      idx := nvcbbpacked.Items.Count; // 目前已存在元素个数
      packaed := IntToStr(idx); // packaed在数据字典从0开始计数
    end
  else
    begin
      packaed := IntToStr(idx);
    end;
//  if Pos(str2, str1) > 0 then
//  begin
//    // 已存在所输入的包装方式
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
//    idx := nvcbbpacked.Items.Count; // 目前已存在元素个数
//    packaed := IntToStr(idx); // packaed在数据字典从0开始计数
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
    SysDialogs.ShowMessage('抵扣积分不能超过当前可用积分!');
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
    SysDialogs.ShowMessage('请输入目的地!');
    nvedtshipprice.Clear;
    nvhelptostation.SetFocus;
    exit;
  end;

  if StrToInt(FormatDateTime('yyyyMMdd', dtpdepartdate.DateTime)) < StrToInt
    (FormatDateTime('yyyyMMdd', Now())) then
  begin
    SysDialogs.ShowMessage('发货日期不能小于今天!');
    dtpdepartdate.SetFocus;
    exit;
  end;


   if (nvhelptostation.Id > 0) then
   begin
      with nvhelpschedule do // 班次
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
    SysDialogs.ShowMessage('请输入目的地!');
    nvhelptostation.SetFocus;
    exit;
    end;

    if StrToInt(FormatDateTime('yyyyMMdd', dtpdepartdate.DateTime))<StrToInt(FormatDateTime('yyyyMMdd', Now())) then
    begin
    SysDialogs.ShowMessage('发货日期不能小于今天!');
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

    with nvhelpschedule do // 班次
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
  deliveryfee : Integer; //送货费
begin
  // 托运费、中转费 、送货费（新增）
  with jcdsquerypackfee do
  begin
    Active := false;
    Params.ParamValues['pieces'] := Trim(nvedtpieces.Text);
    Params.ParamValues['weight'] := Trim(nvedtweight.Text);
    Params.ParamValues['distance'] := distance;
    Execute;
   { if Params.ParamValues['shipprice']=0 then
    begin
       SysDialogs.ShowMessage('收费标准未定义此公里数!');
    end;  }

    // 托运费
    nvedtshipprice.Text := FloatToStr(Params.ParamValues['shipprice']);
    // 装卸费
    nvedthandfee.Text := FloatToStr(Params.ParamValues['handfee']);
    //送货费
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
    // 托运费
    if StrTofloat(nvedtshipprice.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('托运费金额数值超出范围(0~9999.99)!');
      nvedtshipprice.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtshipprice.Text));
  end;

  { if (Trim(nvedtinsurance.Text) <> '') then
    begin
    // 保险费
    if StrToFloat(nvedtinsurance.Text) >= 10000 then
    begin
    SysDialogs.ShowMessage('保险费金额数值超出范围(0~9999.99)!');
    nvedtinsurance.SetFocus;
    exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(Trim(nvedtinsurance.Text));
    end; }

  if (Trim(nvedtinsurancefee.Text) <> '') then
  begin
    // 保价费
    if StrTofloat(nvedtinsurancefee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('保价费金额数值超出范围(0~9999.99)!');
      nvedtinsurancefee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtinsurancefee.Text));
  end;

  if (Trim(nvedtpackfee.Text) <> '') then
  begin
    // 包装费
    if StrTofloat(nvedtpackfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('包装费金额数值超出范围(0~9999.99)!');
      nvedtpackfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtpackfee.Text));
  end;

  if (Trim(nvedthandfee.Text) <> '') then
  begin
    // 装卸费
    if StrTofloat(nvedthandfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('装卸费金额数值超出范围(0~9999.99)!');
      nvedthandfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedthandfee.Text));
  end;

  if (Trim(nvedttransitfee.Text) <> '') then
  begin
    // 中转费
    if StrTofloat(nvedttransitfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('中转费金额数值超出范围(0~9999.99)!');
      nvedttransitfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedttransitfee.Text));
  end;

  if (Trim(nvedtdeliveryfee.Text) <> '') then
  begin
    // 送货费
    if StrTofloat(nvedtdeliveryfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('送货费金额数值超出范围(0~9999.99)!');
      nvedtdeliveryfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtdeliveryfee.Text));
  end;

  if (Trim(nvedtservicefee.Text) <> '') then
  begin
    // 服务费
    if StrTofloat(nvedtservicefee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('服务费用金额数值超出范围(0~9999.99)!');
      nvedtservicefee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtservicefee.Text));
  end;

  if (Trim(nvedtotherfee.Text) <> '') then
  begin
    // 其他费用
    if StrTofloat(nvedtotherfee.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('其他费用金额数值超出范围(0~9999.99)!');
      nvedtotherfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrTofloat(Trim(nvedtotherfee.Text));
  end;

  nvedttotalfee.Text := FloatToStr(totalfeemoney);

  if totalfeemoney >= 10000 then
  begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

end;

procedure TFrmPackacceptAdd.printpack();
begin
  FrmPackacceptReport := TFrmPackacceptReport.Create(self);
  with FrmPackacceptReport do
  begin
    // goodtype:string;//货物类别
    goodtype := '0';
    // sendstationid:Integer;//number(10)	y			发货站
    sendstationvalue := Sysinfo.LoginUserInfo.ticketoutletsname;
    // tostationid:Integer;//number(10)	n			目的地
    tostationvalue := nvhelptostation.Text;
    // name:string;//varchar2(50)	n			货物名称
    name := nvcbbgoodname.Text;
    // scheduleid:Integer;//number(10)	y			班次
    schedulevalue := schedulename; // nvhelpschedule.HelpFieldValue['code'];
    // vehicleid:Integer;//number(10)	n			车牌号
    vehiclevalue := vehiclecodename; // nvhelpschedule.HelpFieldValue['name'];;
    // depart:TDateTime;//date	;//date	y			发货、到货日期
    departdate := FormatDateTime('yyyy-MM-dd', dtpdepartdate.DateTime);
    departtime := self.departtime;
    // packno:string;//varchar2(20)	y			行包单号
    packno := self.packno;
    // invoiceno:string;//varchar2(20)	y			发票号
    invoiceno := self.invoiceno;
    sellbyname := Sysinfo.LoginUserInfo.UserName;
    selltime := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now()); // 受理时间
    // pieces:Integer;//number(3)	y			件数
    pieces := Trim(nvedtpieces.Text);
    // weight:Integer;//number(3)	y			重
    weight := Trim(nvedtweight.Text);
    // volume:string;//varchar2(20)	y			体积
    volume := '0';
    // packaed:Double;//varchar2(10)	y			包装（纸箱、塑料袋、无）
    packaed := '无';
    // shipprice:Double;//number(6,2)	y			托运费
    shippricemoney := Trim(nvedtshipprice.Text);
    // packfee:Double;//number(6,2)	y			包装费
    packfeemoney := Trim(nvedtpackfee.Text);
    // handfee:Double;//number(6,2)	y			装卸费
    handfeemoney := Trim(nvedthandfee.Text);
    // deliveryfee:Double;//                         送货费
    deliveryfeemoney := Trim(nvedtdeliveryfee.Text);
    // custodial:Double;//number(6,2)	y			保管费
    custodialmoney := '0';
    // transitfee:Double;//number(6,2)	y			中转费
    transitfeemoney := Trim(nvedttransitfee.Text);
    // insuredamount:Double;//number(6,2)	y			保价金额
    insuredamountmoney := Trim(nvedtinsuredamount.Text);
    // insurancefee:Double;//number(6,2)	y			保价费
    insurancefeemoney := Trim(nvedtinsurancefee.Text);
    // insurance:Double;//number(6,2)	y			保险费
    insurancemoney := '';
    // servicefeemoney:Double;//number(6,2)	y			服务费
    servicefeemoney :=Trim(nvedtservicefee.Text);
    // otherfee:Double;//number(6,2)	y			其他费用
    otherfeemoney := Trim(nvedtotherfee.Text);
    // totalfee:Double;//number(6,2)	y			合计金额
    totalfeemoney := Trim(nvedttotalfee.Text);
    // location:string;//varchar2(20)	y			存放位置
    // packprice:Double;//number(6,2)	y			代收货款
    packpricemoney := Trim(nvedtpackprice.Text);
    // 合计金额+代收货款
    if (nvcbbpaymethod.GetSelectCode = '0') then
      // 现付
      totalprice := FloatToStr(StrTofloat(Trim(nvedtpackprice.Text)))
    else
      // 提付
      totalprice := FloatToStr(StrTofloat(Trim(nvedtpackprice.Text))
          + StrTofloat(Trim(nvedttotalfee.Text)));

    // sender:string;//varchar2(30)	y			托运人
    Sender := Trim(nvedtsender.Text);
    // senderphone:string;//varchar2(20)	y			托运人电话
    senderphone := Trim(nvedtsenderphone.Text);
    // senderaddress:string;//varchar2(100)	y			托运人地址
    senderaddress := Trim(nvedtsenderaddress.Text);
    // consignee:string;//varchar2(30)	y			收货人
    consignee := Trim(nvedtconsignee.Text);
    // consigneephone:string;//varchar2(20)	y			收货人电话
    consigneephone := Trim(nvedtconsigneephone.Text);
    // consigneeaddress:string;//varchar2(100)	y			收货人地址
    consigneeaddress := Trim(nvedtconsigneeaddress.Text);
    // certificatetype:string;//varchar2(10)	y			证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
    certificatetype := nvcbbcertificatetype.GetSelectValue;
    // certificateno:string;//varchar2(30)	y			证件号码
    certificateno := Trim(nvedtcertificateno.Text);
    // shiptype:string;//varchar2(10)	y			托运方式（随车自提、收获人提领）取数据字典
    shiptype := nvcbbshiptype.GetSelectValue;
    // paymethod:string;//varchar2(10)	y			付款方式（现付、提付）取数据字典
    paymethod := nvcbbpaymethod.GetSelectValue;
    // valuables:string;//number(1)	y			是否贵重物品
    if rbvaluablesno.checked then
      valuables := '否'
    else
      valuables := '是';
    remarks := Trim(memremarks.Text); // 货物描述

    PrintPackReport;

    if isprintInvoice = '1' then
    begin
       PrintPackInvoiceReport; //打印发票
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
      // SysDialogs.ShowMessage('查找数据异常，返回结果数小于预期数!');
      // exit;
      // end
      // else if jcdsResult.DataSize > 1 then
      // begin
      // SysDialogs.ShowMessage('查找数据异常，返回结果数大于预期数!');
      // exit;
      // end;

      printValue := TDictionary<String, String>.Create;
      billPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('行包签发单', '行包签发单'));
      printValue.Clear;
      multiplelists := TList < TDictionary < String, String >> .Create;
      // 签发单号、发车日期、班次号、车牌号码、驾驶员、营运单位、行包件数、总金额，
      printValue.add('singbillno',
        Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill']); // 签发单号
      // 发车日期
      printValue.add('departdate', FormatDateTime('yyyy-MM-dd',
          dtpdepartdate.DateTime));

      // 发车时间
      printValue.add('departtime', '');
      // 班次
      printValue.add('schedulevalue', '');
      // 车牌号
      printValue.add('vehiclevalue', '');
      // 驾驶员
      printValue.add('drivername', drivername);

      printValue.add('unitname', vehunitname); // 营运单位
      printValue.add('piecesnums', nvedtpieces.Text); // 行包件数
      printValue.add('totalfeecountmoney', nvedttotalfee.Text); // 总金额
      printValue.add('sellbyname', Sysinfo.LoginUserInfo.UserName); // 签发人
      printValue.add('printdate', FormatDateTime('yyyy-MM-dd HH:mm:ss', Now));
      // 签发时间
      printValue.add('sendstation', Sysinfo.LoginUserInfo.ticketoutletsname);
      // 签发站

      multipleValueValue := TDictionary<String, String>.Create;
      multipleValueValue.add('packno', packno); // 托运单号
      multipleValueValue.add('sender', nvedtsender.Text); // 托运人
      multipleValueValue.add('senderphone', nvedtsenderphone.Text); // 托运人电话
      multipleValueValue.add('tostationvalue', nvhelptostation.Text); // 到站
      multipleValueValue.add('consignee', nvedtconsignee.Text); // 收货人
      multipleValueValue.add('consigneephone', nvedtconsigneephone.Text);
      // 收货人电话
      multipleValueValue.add('pieces', nvedtpieces.Text); // 件数
      multipleValueValue.add('totalfeemoney', nvedttotalfee.Text); // 合计金额
      multipleValueValue.add('shippricemoney', nvedtshipprice.Text); // 托运费
      multipleValueValue.add('packfeemoney', nvedtpackfee.Text); // 包装费
      multipleValueValue.add('handfeemoney', nvedthandfee.Text); // 装卸费
      multipleValueValue.add('deliveryfeemoney', nvedtdeliveryfee.Text);
      // 送货费
      multipleValueValue.add('transitfeemoney', nvedttransitfee.Text); // 中转费
      multipleValueValue.add('insuredamountmoney', nvedtinsuredamount.Text);
      // 声明价值
      multipleValueValue.add('insurancefeemoney', nvedtinsurancefee.Text);
      // 保价费
      multipleValueValue.add('insurancemoney', ''); // 保险费
      multipleValueValue.add('otherfeemoney', nvedtotherfee.Text); // 其他费用
      multipleValueValue.add('packpricemoney', nvedtpackprice.Text); // 代收货款

      multiplelists.add(multipleValueValue);

      try
        log := '行包受理签发：机构=' + Sysinfo.LoginUserInfo.orgname + ',签发票号=' +
          Sysinfo.LoginUserInfo.curBillNo.Items['PackSgBill']
          + ',签发人=' + Sysinfo.LoginUserInfo.UserName + ',行包件数=' +
          nvedtpieces.Text + ',总金额=' + nvedttotalfee.Text + ',签发时间=' +
          FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ',托运单号=' + Trim
          (nvedtpackno.Text);

        SysLog.WriteLog('行包管理->行包库存', '行包签发', log);

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
