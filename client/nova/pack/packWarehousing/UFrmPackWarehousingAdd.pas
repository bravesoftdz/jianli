unit UFrmPackWarehousingAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls, NovaPrint, Generics.Collections,
  NovaCheckedComboBox;

type
  TFrmPackWarehousingAdd = class(TSimpleEditForm)
    jcdspacksave: TjsonClientDataSet;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Label11: TLabel;
    Label34: TLabel;
    nvedtshipprice: TNovaEdit;
    Label33: TLabel;
    nvedtpackprice: TNovaEdit;
    Label51: TLabel;
    Label39: TLabel;
    nvedtpieces: TNovaEdit;
    Label8: TLabel;
    nvcbbpacked: TNovaComboBox;
    Label7: TLabel;
    nvhelpvehiclecode: TNovaHelp;
    Label5: TLabel;
    Label3: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    nvedtconsigneephone: TNovaEdit;
    nvedtconsignee: TNovaEdit;
    Label24: TLabel;
    Label22: TLabel;
    nvedtpackarriverno: TNovaEdit;
    jcdsdistance: TjsonClientDataSet;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    jcdsquerypackfee: TjsonClientDataSet;
    wdstrngfldResultshowvalue: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    Label19: TLabel;
    nvedttotalfee: TNovaEdit;
    Label26: TLabel;
    nvhelpsendstationid: TNovaHelp;
    Label49: TLabel;
    nvedtotherfee: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbltoendstation: TLabel;
    lblsellby: TLabel;
    lbldepartdate: TLabel;
    dtpdepartdate: TDateTimePicker;
    nvhelpzytostationid: TNovaHelp;
    Label2: TLabel;
    jcdsupdateBillinuse: TjsonClientDataSet;
    nvcbblocation: TNovaComboBox;
    nvedtpacked: TNovaEdit;
    nvcbbentrypacker: TNovaCheckedComboBox;
    Label4: TLabel;
    nvcbbgoodsstatus: TNovaComboBox;
    Label14: TLabel;
    Label18: TLabel;
    nvedttransitfee: TNovaEdit;
    nvedtservicefee: TNovaEdit;
    Label20: TLabel;
    nveditpackname: TNovaEdit;
    Label21: TLabel;
    Label23: TLabel;
    nvcbbshiptype: TNovaComboBox;
    Label25: TLabel;
    nvcbbpaymethod: TNovaComboBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    jcdspacktypesave: TjsonClientDataSet;
    Label30: TLabel;
    Label6: TLabel;
    nvedtpackno: TNovaEdit;
    Label9: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtshippriceChange(Sender: TObject);
    procedure nvcbbpaymethodChange(Sender: TObject);
    procedure nvcbbpackedChange(Sender: TObject);
    procedure nvedtpackedExit(Sender: TObject);

  private
    { Private declarations }
    Foperationid: Integer;
    isdrawbill: string; // 是否需要领用到货收讫票证
    log: string;
    packprint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    procedure totalfeemoney;
    procedure updatepackarrivalbill;
  public
    { Public declarations }
    packarriverno: String; // 行包收讫单号
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
    pieces: Integer; // number(3)	y			件数
    weight: Double; // number(3)	y			重量
    volume: string; // varchar2(20)	y			体积
    packaed: string; // varchar2(10)	y			包装（纸箱、塑料袋、无）
    shipprice: Double; // number(6,2)	y			托运费
    packfee: Double; // number(6,2)	y			包装费
    handfee: Double; // number(6,2)	y			装卸费
    deliveryfee: Double; // 送货费
    custodial: Double; // number(6,2)	y			保管费
    transitfee: Double; // number(6,2)	y			中转费
    insuredamount: Double; // number(6,2)	y			保价金额
    insurancefee: Double; // number(6,2)	y			保价费
    insurance: Double; // number(6,2)	y			保险费
    otherfee: Double; // number(6,2)	y			其他费用
    totalfee: Double; // number(6,2)	y			合计金额
    location: string; // varchar2(20)	y			存放位置
    packprice: Double; // number(6,2)	y			代收货款
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
    createtime: TDateTime; // date	n	sys;//date
    createby: Integer; // number(10)	n
    updatetime: TDateTime; // date	n	sys;//date
    updateby: Integer; // number(10)	n

    distance: Integer; // 公里数
    isinputpacked: boolean; // 包装类别是否为输入
    packarriverid : Integer;//行包收讫表id
    packarrivercreateby : Integer;//行包收讫表createby
    packarrivercreatetime : String;//行包收讫表createtime

    property operationid: Integer read Foperationid;
  end;

var
  FrmPackWarehousingAdd: TFrmPackWarehousingAdd;

implementation

uses PubFn, DateUtils;
{$R *.dfm}

procedure TFrmPackWarehousingAdd.bbtnSaveClick(Sender: TObject);

var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result: string;
  packstatus: string;
  packstatusvalue: string;
begin
  inherited;

  if trim(nvedtpackarriverno.Text) = '' then
  begin
    SysDialogs.ShowMessage('行包收讫单号不能为空!');
    nvedtpackarriverno.SetFocus;
    exit;
  end;

  if trim(nvedtpackno.Text) = '' then
  begin
    SysDialogs.ShowMessage('行包单号不能为空!');
    nvedtpackno.SetFocus;
    exit;
  end;

  if trim(nveditpackname.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入行包名称!');
    nveditpackname.SetFocus;
    exit;
  end;

  if (trim(nvedtpieces.Text) = '') then
  begin
    SysDialogs.ShowMessage('件数不能为空!');
    nvedtpieces.Text := '1';
    nvedtpieces.SetFocus;
    exit;
  end;

  if nvhelpvehiclecode.Id <= 0 then
  begin
    SysDialogs.ShowMessage('请输入车牌号!');
    nvhelpvehiclecode.SetFocus;
    exit;
  end;

  if nvhelpsendstationid.Id <= 0 then
  begin
    SysDialogs.ShowMessage('请输入发货站!');
    nvhelpsendstationid.SetFocus;
    exit;
  end;

  if nvcbbpacked.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择包装类型!');
    nvcbbpacked.SetFocus;
    exit;
  end;

  if nvcbbgoodsstatus.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择行包状态!');
    nvcbbgoodsstatus.SetFocus;
    exit;
  end;

  if (nvcbblocation.ItemIndex < 0) then
  begin
    SysDialogs.ShowMessage('请选择行包存放位置!');
    nvcbblocation.SetFocus;
    exit;
  end;

  if (nvcbbshiptype.ItemIndex < 0) then
  begin
    SysDialogs.ShowMessage('请选择提货方式!');
    nvcbbshiptype.SetFocus;
    exit;
  end;

  // if Trim(nvedtconsignee.Text) = '' then
  // begin
  // SysDialogs.ShowMessage('货主姓名不能为空!');
  // nvedtconsignee.SetFocus;
  // exit;
  // end;

  // if Trim(nvedtconsigneephone.Text) = '' then
  // begin
  // SysDialogs.ShowMessage('货主电话不能为空!');
  // nvedtconsigneephone.SetFocus;
  // exit;
  // end;

  if (nvcbbpaymethod.ItemIndex < 0) then
  begin
    SysDialogs.ShowMessage('请选择付款方式!');
    nvcbbpaymethod.SetFocus;
    exit;
  end;

  if (nvcbbpaymethod.ItemIndex = 1) then // 对付
  begin
    Label30.Visible := True;
    if (StrTOFloat(nvedtpackprice.Text) <= 0) then
    begin
      SysDialogs.ShowMessage('付款方式为对付，货款不能为0!');
      nvedtpackprice.SetFocus;
      exit;
    end;
  end
  else
  begin
    Label30.Visible := False;
  end;

  if (trim(nvedtshipprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('运费不能为空!');
    nvedtshipprice.SetFocus;
    exit;
  end;

  if (trim(nvedtotherfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('其他费用不能为空!');
    nvedtotherfee.Text := '0';
    nvedtotherfee.SetFocus;
    exit;
  end;

  if (trim(nvedtpackprice.Text) = '') then
  begin
    SysDialogs.ShowMessage('货款不能为空!');
    nvedtpackprice.Text := '0';
    nvedtpackprice.SetFocus;
    exit;
  end;

  if (trim(nvedttotalfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('合计金额不能为空!');
    nvedttotalfee.Text := '0';
    nvedttotalfee.SetFocus;
    exit;
  end;

  // if StrTOFloat(nvedtshipprice.Text) >= 10000 then
  // begin
  // SysDialogs.ShowMessage('运费金额数值超出范围(0~9999.99)!');
  // nvedtshipprice.SetFocus;
  // exit;
  // end;
  //
  // if StrTOFloat(nvedtotherfee.Text) >= 10000 then
  // begin
  // SysDialogs.ShowMessage('其他费用金额数值超出范围(0~9999.99)!');
  // nvedtotherfee.SetFocus;
  // exit;
  // end;
  //
  // if StrTOFloat(nvedttotalfee.Text) >= 10000 then
  // begin
  // SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
  // nvedttotalfee.SetFocus;
  // exit;
  // end;
  //
  // if StrTOFloat(nvedtpackprice.Text) >= 1000000 then
  // begin
  // SysDialogs.ShowMessage('代收货款金额数值超出范围(0~999999.99)!');
  // nvedtpackprice.SetFocus;
  // exit;
  // end;

  if (nvcbbentrypacker.GetSelectID = '') then
  begin
    SysDialogs.ShowMessage('请输入操作人');
    nvcbbentrypacker.SetFocus;
    exit;
  end;

  with jcdspacksave do
  begin
    Active := False;
    if self.edittype = Tedittype.update then
    begin
      // 收讫单号
      Params.ParamByName('packarriver.id').Value := packarriverid;
      Params.ParamByName('packarriver.packarriverno').Value := trim(nvedtpackarriverno.Text);
      Params.ParamByName('packarriver.updateby').Value := Sysinfo.LoginUserInfo.UserID;
      Params.ParamByName('packarriver.createby').Value := packarrivercreateby;
      Params.ParamByName('packarriver.createtime').Value := packarrivercreatetime;
//        nvedtpackarriverno.Text;
      // 行包单号
      Params.ParamValues['pack.id'] := IntToStr(packid);
    end
    else
    begin
      // 收讫单号
      Params.ParamByName('packarriver.packarriverno').Value := trim(nvedtpackarriverno.Text);
      Params.ParamByName('packarriver.createby').Value := Sysinfo.LoginUserInfo.UserID;
      Params.ParamByName('packarriver.createtime').Value := now();

    end;

    // ---------行包收讫单----------
    // 收讫日期
    Params.ParamByName('packarriver.arriverdate').Value := FormatDateTime
      ('yyyy-mm-dd', dtpdepartdate.DateTime);
    // 发货站
    Params.ParamByName('packarriver.sendstationid').Value := IntToStr
      (nvhelpsendstationid.Id);
    // 服务费
    Params.ParamByName('packarriver.servicefee').Value := trim
      (nvedtservicefee.Text);
    // 代收运费=入仓时总金额
    Params.ParamByName('packarriver.packfee').Value := trim(nvedttotalfee.Text);
    // 货款
    Params.ParamByName('packarriver.packprice').Value := trim
      (nvedtpackprice.Text);
    // 中转至
    Params.ParamByName('packarriver.transitstationid').Value := IntToStr
      (nvhelpzytostationid.Id);
    // 操作人
    Params.ParamByName('packarriver.receiver').Value :=
      Sysinfo.LoginUserInfo.StationID;
    // 收货人
    if (trim(nvedtconsignee.Text) = '') then
      Params.ParamByName('packarriver.consignee').Value := '无'
    else
      Params.ParamByName('packarriver.consignee').Value := trim
        (nvedtconsignee.Text);
    // 收货人电话
    if (trim(nvedtconsigneephone.Text) = '') then
      Params.ParamByName('packarriver.consigneephone').Value := '无'
    else
      Params.ParamByName('packarriver.consigneephone').Value := trim
        (nvedtconsigneephone.Text);
    // 件数
    Params.ParamByName('packarriver.pieces').Value := trim(nvedtpieces.Text);
    // 包装
    if isinputpacked then
    begin
      Params.ParamByName('packarriver.packed').Value := packaed; // 手动输入包装类别
    end
    else
    begin
      Params.ParamByName('packarriver.packed').Value :=
        nvcbbpacked.GetSelectCode;
    end;
    // 存放位置
    Params.ParamByName('packarriver.location').Value :=
      nvcbblocation.GetSelectCode;
    // 状态：0：未结算；1：已注销：2：已结算
    Params.ParamByName('packarriver.status').Value := '0';

    // -------行包受理单----------
    Params.ParamByName('pack.sellby').Value := IntToStr
      (Sysinfo.LoginUserInfo.UserID);
    Params.ParamByName('pack.createtime').Value := FormatDateTime('yyyy-mm-dd',
      createtime);
    // 发货、到货日期
    Params.ParamByName('pack.departdate').Value := FormatDateTime('yyyy-mm-dd',
      dtpdepartdate.DateTime);
    // packtype varchar2(10)				行包类型（0：发货，1：到货
    Params.ParamByName('pack.packtype').Value := '1';
    // 货物类别
     Params.ParamByName('pack.goodtype').Value:= '0';
    // 行包单号
    Params.ParamValues['pack.packno'] := nvedtpackno.Text;
    // 货物名称
    Params.ParamByName('pack.name').Value := nveditpackname.Text;
    // 件数
    Params.ParamByName('pack.pieces').Value := trim(nvedtpieces.Text);
    // 车牌号
    if (nvhelpvehiclecode.Text = '') or (nvhelpvehiclecode.Id < 0) then
    begin
      Params.ParamByName('pack.vehicleid').Value := '';
    end
    else
    begin
      Params.ParamByName('pack.vehicleid').Value := IntToStr
        (nvhelpvehiclecode.Id);
    end;
    // 发货站
    Params.ParamByName('pack.sendstationid').Value := IntToStr
      (nvhelpsendstationid.Id);
    // 目的地
    Params.ParamByName('pack.tostationid').Value := IntToStr
      (Sysinfo.LoginUserInfo.orgid);
    // 包装
    if isinputpacked then
    begin
      Params.ParamByName('pack.packed').Value := packaed; // 手动输入包装类别
    end
    else
    begin
      Params.ParamByName('pack.packed').Value := nvcbbpacked.GetSelectCode;
    end;
    // 货物状态
    Params.ParamByName('pack.goodsstatus').Value :=
      nvcbbgoodsstatus.GetSelectCode;
    // 存放位置
    Params.ParamByName('pack.location').Value := nvcbblocation.GetSelectCode;
    // 收货人
    Params.ParamByName('pack.consignee').Value := trim(nvedtconsignee.Text);
    // 收货人电话
    Params.ParamByName('pack.consigneephone').Value := trim
      (nvedtconsigneephone.Text);
    // 收货人地址
    Params.ParamByName('pack.consigneeaddress').Value := '';
    // 提货方式 托运方式随车自提、收获人提领）取数据字
    Params.ParamByName('pack.shiptype').Value := nvcbbshiptype.GetSelectID;
    // 转运至
    if nvhelpzytostationid.Id > 0 then
    begin
      Params.ParamByName('pack.zhuanyuntostationid').Value := IntToStr
        (nvhelpzytostationid.Id);
      Params.ParamByName('packarriver.transitstationid').Value := IntToStr
        (nvhelpzytostationid.Id)
    end
    else
    begin
      Params.ParamByName('pack.zhuanyuntostationid').Value := '';
      Params.ParamByName('packarriver.transitstationid').Value := '';
    end;

    // Params.ParamByName('pack.packno').Value := trim(nvedtpackno.Text); // 行包单号
    // Params.ParamByName('pack.invoiceno').Value := ''; // 发票号
    // Params.ParamByName('pack.weight').Value := 0; // 重
    // Params.ParamByName('pack.volume').Value := trim(nvedtvolume.Text);//体积

    // 付款方式（现付、提付）取数据字典
    Params.ParamByName('pack.paymethod').Value := IntToStr
      (nvcbbpaymethod.ItemIndex);
    // 对付款回收状态
    if (nvcbbpaymethod.ItemIndex = 1) then
    begin
      Params.ParamByName('pack.recyclestatus').Value := '0';
    end;

    // 托运费
    Params.ParamByName('pack.shipprice').Value := trim(nvedtshipprice.Text);
    // 中转费
    Params.ParamByName('pack.transitfee').Value := trim(nvedttransitfee.Text);
    // 其他费
    Params.ParamByName('pack.otherfee').Value := trim(nvedtotherfee.Text);
    // 合计金额 Double;//number(6,2)	y
    Params.ParamByName('pack.totalfee').Value := trim(nvedttotalfee.Text);
    // 货款
    Params.ParamByName('pack.packprice').Value := trim(nvedtpackprice.Text);
    // 收讫人 操作人
    Params.ParamByName('pack.entrypacker').Value := nvcbbentrypacker.Text;

    // 状态(0：库存、1：签发、2：提领、3：作废) 4到货库存
    Params.ParamByName('pack.status').Value := '4';
    // orgid:I
    Params.ParamByName('pack.orgid').Value := Sysinfo.LoginUserInfo.orgid;
    // createby
    Params.ParamByName('pack.createby').Value := IntToStr(createby);
    // 服务费
    Params.ParamByName('pack.servicefee').Value := trim(nvedtservicefee.Text);

    // Params.ParamByName('pack.packfee').Value := 0; // 包装费
    // Params.ParamByName('pack.handfee').Value := 0; // 发货装卸费
    // Params.ParamByName('pack.unloadfee').Value := 0; // 到货装卸费
    // Params.ParamByName('pack.deliveryfee').Value := 0; // 送货费
    // Params.ParamByName('pack.custodial').Value := '0'; // 保管费
    // Params.ParamByName('pack.insuredamount').Value := 0; // 保价金额
    // Params.ParamByName('pack.insurancefee').Value := 0; // 保价费
    // Params.ParamByName('pack.insurance').Value := 0; // 保险费
    // Params.ParamByName('pack.sender').Value := ''; // 托运人
    // Params.ParamByName('pack.senderphone').Value := '';// 托运人电话
    // Params.ParamByName('pack.senderaddress').Value := ''; // 托运人地址
    // Params.ParamByName('pack.certificatetype').Value :=''; // 证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
    // Params.ParamByName('pack.certificateno').Value := ''; // 证件号码

    Execute;

    // bbtnSave.Enabled :=true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled := False;
      if packid > 0 then
      begin
        result := '修改';
      end
      else
      begin
        result := '添加';
        if isdrawbill = '1' then
        begin

          if not Assigned(packprint) then
            packprint := TNovaPrint.Create(self,
              TNovaPrint.GetTicketModelName('到货收讫单', '到货收讫单'));
          if not Assigned(printValue) then
            printValue := TDictionary<String, String>.Create
          else
            printValue.Clear;
          printValue.Add('P_NO', nvedtpackarriverno.Text);
          printValue.Add('departdate', FormatDateTime('yyyy-mm-dd',
              dtpdepartdate.DateTime));
          printValue.Add('sendstationvalue', nvhelpsendstationid.Text);
          printValue.Add('vehiclevalue', nvhelpvehiclecode.Text);
          printValue.Add('shippricemoney', nvedttotalfee.Text);  // 代收运费：应为合计金额
          printValue.Add('packpricemoney', nvedtpackprice.Text);  //代收货款
          printValue.Add('shiptostation', nvhelpzytostationid.Text);
          printValue.Add('sellbyname', nvcbbentrypacker.Text); // 到货入仓操作员
          printValue.Add('consignee', nvedtconsignee.Text);
          printValue.Add('consigneephone', nvedtconsigneephone.Text);
          if isinputpacked then
          begin
            printValue.Add('packed', Trim(nvedtpacked.Text) );    //手动输入
          end
          else
          begin
             printValue.Add('packed',nvcbbpacked.GetSelectValue );
          end;
          
          printValue.Add('location', nvcbblocation.Text);
          printValue.Add('totalprice', nvedttotalfee.Text);
          printValue.Add('pieces', nvedtpieces.Text);
          packprint.SingleValue := printValue;
          packprint.Print;

          updatepackarrivalbill;
        end;
      end;

      self.ModalResult := mrOk;
    end;

    // Foperationid := Params.ParamValues['packid'];

  end;
end;

procedure TFrmPackWarehousingAdd.FormCreate(Sender: TObject);
begin
  inherited;
  isdrawbill := getParametervalue('8068', Sysinfo.LoginUserInfo.orgid);
  Label30.Visible := False;
  nvedtpackarriverno.Text := packarriverno; // 收讫单号
  dtpdepartdate.DateTime := now;
  nvcbbpacked.Active := True;
  nvcbbpacked.ItemIndex := 1;
  nvedtpacked.Visible := False;
  nvcbbgoodsstatus.Active := True;
  nvcbbgoodsstatus.ItemIndex := 0;
  nvcbblocation.Active := True;
  nvcbblocation.ItemIndex := 0;
  nvcbbshiptype.Active := True;
  nvcbbshiptype.ItemIndex := 0;
  nvcbbpaymethod.Active := True;
  nvcbbpaymethod.ItemIndex := 0;
  with nvcbbentrypacker do
  begin
    nvcbbentrypacker.Active := False;
    Params.ParamValues['filter_INS_u!orgid'] := ''; // 组织机构
    Params.ParamValues['filter_INS_r!id'] := '(2,38767)'; // 有入仓权限的角色：入库人员 ,管理员
    nvcbbentrypacker.Active := True;
  end;

end;

procedure TFrmPackWarehousingAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then
    nveditpackname.SetFocus
  else
  begin
    if isdrawbill = '1' then
    begin
      nvedtpackarriverno.Text := packarriverno; // 行包收讫单号;
      // nvedtpackarriverno.Enabled := false;
      nvedtpackno.SetFocus
    end
    else
      nvedtpackno.SetFocus;
  end;

end;

procedure TFrmPackWarehousingAdd.nvcbbpackedChange(Sender: TObject);
begin
  inherited;
  if nvcbbpacked.ItemIndex = 0 then
  begin
    nvedtpacked.Visible := True;
    nvedtpacked.Enabled := True;
  end
  else
  begin
    nvedtpacked.Visible := False;
    nvedtpacked.Text := '';
  end;
end;

procedure TFrmPackWarehousingAdd.nvcbbpaymethodChange(Sender: TObject);
begin
  inherited;
  if (nvcbbpaymethod.ItemIndex = 1) then
  begin
    Label30.Visible := True;
    nvedtshipprice.SetFocus;
  end
  else
  begin
    Label30.Visible := False;
  end;

  totalfeemoney;

end;

procedure TFrmPackWarehousingAdd.nvedtpackedExit(Sender: TObject);
var
  str1, str2: String;
var
  idx: Integer;
begin
  inherited;
  isinputpacked := True;
  str1 := nvcbbpacked.Items.Text;
  str2 := trim(nvedtpacked.Text);

  idx := nvcbbpacked.Items.IndexOf(str2);
  if idx < 0 then
  begin
    // 新包装方式
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
  // if Pos(str2, str1) > 0 then
  // begin
  // // 已存在所输入的包装方式
  // // idx := nvcbbpacked.Items.IndexOfName(str2);
  // idx := nvcbbpacked.Items.IndexOf(str2);
  // packaed := IntToStr(idx);
  // end
  // else
  // begin
  // if str2 <> '' then
  // with jcdspacktypesave do
  // begin
  // Params.ParamValues['newPackType'] := str2;
  // Execute;
  // end;
  // idx := nvcbbpacked.Items.Count; // 目前已存在元素个数
  // packaed := IntToStr(idx); // packaed在数据字典从0开始计数
  // end;
end;

procedure TFrmPackWarehousingAdd.nvedtshippriceChange(Sender: TObject);
begin
  inherited;
  // totalfeemoney;
  if (trim(nvedtshipprice.Text) <> '') then
  begin
    // 运费
    if StrTOFloat(nvedtshipprice.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('运费金额数值超出范围(0~9999.99)!');
      nvedtshipprice.SetFocus;
      exit;
    end;
  end;

  // 中转费
  if (trim(nvedttransitfee.Text) <> '') then
  begin
    if (StrTOFloat(nvedttransitfee.Text) >= 10000) then
    begin
      SysDialogs.ShowMessage('中转费金额数值超出范围(0~9999.99)!');
      nvedttransitfee.SetFocus;
      exit;
    end;
  end;

  // 服务费
  if (trim(nvedtservicefee.Text) <> '') then
  begin
    if (StrTOFloat(nvedtservicefee.Text) >= 10000) then
    begin
      SysDialogs.ShowMessage('服务费金额数值超出范围(0~9999.99)!');
      nvedtservicefee.SetFocus;
      exit;
    end;
  end;
  // 其他费
  if (trim(nvedtotherfee.Text) <> '') then
  begin
    if (StrTOFloat(nvedtotherfee.Text) >= 10000) then
    begin
      SysDialogs.ShowMessage('其他费金额数值超出范围(0~9999.99)!');
      nvedtotherfee.SetFocus;
      exit;
    end;
  end;

  // 合计金额
  nvedttotalfee.Text := FloatToStr(StrTOFloat(trim(nvedtshipprice.Text))
      + StrTOFloat(trim(nvedttransitfee.Text)) + StrTOFloat
      (trim(nvedtservicefee.Text)) + StrTOFloat(trim(nvedtotherfee.Text)));

  if StrTOFloat(nvedttotalfee.Text) >= 10000 then
  begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  // 代收货款
  if (trim(nvedtpackprice.Text) <> '') then
  begin
    if (StrTOFloat(nvedtpackprice.Text) >= 10000) then
    begin
      SysDialogs.ShowMessage('代收货款金额数值超出范围(0~9999.99)!');
      nvedtpackprice.SetFocus;
      exit;
    end;
  end;

end;

procedure TFrmPackWarehousingAdd.totalfeemoney();
var
  totalfeemoney: Double;
begin
  totalfeemoney := 0;
  if (trim(nvedtshipprice.Text) <> '') then
  begin
    // 代收运费
    if StrTOFloat(nvedtshipprice.Text) >= 10000 then
    begin
      SysDialogs.ShowMessage('代收运费金额数值超出范围(0~9999.99)!');
      nvedtshipprice.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrTOFloat(trim(nvedtshipprice.Text));
  end;

  nvedttotalfee.Text := FloatToStr(totalfeemoney);

  if totalfeemoney >= 10000 then
  begin
    SysDialogs.ShowMessage('合计金额数值超出范围(0~9999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

end;

procedure TFrmPackWarehousingAdd.updatepackarrivalbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with Sysinfo.LoginUserInfo do
  begin
    billinusenextform := IntToStr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']));
    billinusenextno := IntToStr
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
