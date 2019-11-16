{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR OFF}
{$WARN CVT_WIDENING_STRING_LOST OFF}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
unit UFrmPackGoodsAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls,NovaPrint,Generics.Collections;

type
  TFrmPackGoodsAdd = class(TSimpleEditForm)
    Label17: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label35: TLabel;
    Label42: TLabel;
    Label1: TLabel;
    Label26: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nvedtnum: TNovaEdit;
    nvedtcustomer: TNovaEdit;
    nvedtphone: TNovaEdit;
    nvedtidcardno: TNovaEdit;
    nvcbbgoodstype: TNovaComboBox;
    nvedtlocation: TNovaEdit;
    dtppickupenddate: TDateTimePicker;
    memremarks: TMemo;
    nvedtcustodial: TNovaEdit;
    nvedtpieces: TNovaEdit;
    jcdsgoodssave: TjsonClientDataSet;
    jcdsupdateBillinuse: TjsonClientDataSet;
    Label5: TLabel;
    nvedtgoodsno: TNovaEdit;
    Label7: TLabel;
    Label8: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtppickupenddateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Foperationid: Integer;
    log:string;
    schedulename,vehiclecodename:string;
    storagefee:Double;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    procedure printpack;
    procedure updatepackbill;
  public
    { Public declarations }
  goodsid:Integer;
  goodsno:string;//varchar2(20)y寄存单号
  num:string;//varchar2(10)y保管牌号
  customer:string;//varchar2(20)y旅客姓名
  phone:string;//varchar2(20)y旅客电话
  idcardno:string;//varchar2(20)y身份证
  goodstype:string;//varchar2(10)y小件类别:（0：纸箱、1：提包、2：背包、3：行李箱）取数据字典
  pieces:Integer;//number(5)y件数
  location:string;//varchar2(20)y存放位置
  pickupenddate:TDateTime;//date提取截止日期
  deposittiime:TDateTime;//date寄存时间
  custodial:Double;//number(6,2)y保管费
  penalty:Double;//number(6,2)y滞纳金
  totalfee:Double;//number(6,2)y合计金额
  consignee:Integer;//number(10)y收货人
  consigneename:string;
  status:string;//varchar2(10)y状态（0：库存、1：已提领，2：作废）
  pickuper:string;//varchar2(30)y提领人
  pickupdate:TDateTime;//date提领日期
  operatorby:Integer;//number(10)y办理员
  remak:string;//varchar2(50)y备注
  orgid:Integer;//number(10)y
  createtime:TDateTime;//datensysdate
  createby:Integer;//number(10)n
  updatetime:TDateTime;//datensysdate
  updateby:Integer;//number(10)n
  property operationid: Integer read Foperationid;
  end;

var
  FrmPackGoodsAdd:TFrmPackGoodsAdd;

implementation
uses PubFn,DateUtils;
{$R *.dfm}

procedure TFrmPackGoodsAdd.bbtnSaveClick(Sender: TObject);
var result:string;
begin
  inherited;
if Trim(nvedtnum.Text) = '' then
    begin
      SysDialogs.ShowMessage('保管牌号不能为空!');
      nvedtnum.SetFocus;
      exit;
    end;

    if Trim(nvedtcustomer.Text) = '' then
    begin
      SysDialogs.ShowMessage('旅客姓名不能为空!');
      nvedtnum.SetFocus;
      exit;
    end;

    if Trim(nvedtphone.Text) = '' then
    begin
      SysDialogs.ShowMessage('旅客电话不能为空!');
      nvedtphone.SetFocus;
      exit;
    end;
    {
    if Trim(nvedtidcardno.Text) = '' then
    begin
      SysDialogs.ShowMessage('身份证不能为空!');
      nvedtidcardno.SetFocus;
      exit;
    end;

    if not (ValidatePID(nvedtidcardno.Text) ='') then
    begin
      SysDialogs.ShowMessage(ValidatePID(nvedtidcardno.Text));
      nvedtidcardno.SetFocus;
      exit;
    end;
     }
    if nvcbbgoodstype.ItemIndex<0 then
    begin
      SysDialogs.ShowMessage('请选择小件类别!');
      nvcbbgoodstype.SetFocus;
      exit;
    end;

    if (Trim(nvedtpieces.Text) = '') then
    begin
      SysDialogs.ShowMessage('件数不能为空!');
      nvedtpieces.Text :='1';
      nvedtpieces.SetFocus;
      exit;
    end;

    if StrToInt(FormatDateTime('yyyyMMdd', dtppickupenddate.DateTime))<StrToInt(FormatDateTime('yyyyMMdd', Now())) then
    begin
      SysDialogs.ShowMessage('提取截止日期不能小于今天!');
      dtppickupenddate.SetFocus;
      exit;
    end;

    if StrToFloat(nvedtcustodial.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('保管费金额数值超出范围(0~9999.99)!');
      nvedtcustodial.SetFocus;
      exit;
    end;


    with jcdsgoodssave do
    begin
      Active :=false;
      if self.edittype = Tedittype.update then
      begin
        Params.ParamByName('goods.goodsno').Value:= Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];//goodsno;//寄存单号
  //      consignee := consignee;//收货人
        Params.ParamValues['goods.id'] := IntToStr(goodsid);
        Params.ParamValues['goods.createby']:= IntToStr(createby);
        Params.ParamValues['goods.createtime']:= FormatDateTime('yyyy-mm-dd HH:mm:ss', createtime);
  //      deposittiime := deposittiime;//寄存时间
         Params.ParamByName('goods.orgid').Value := IntToStr(orgid);
      end
      else
      begin
        deposittiime:=  Now();//寄存时间
        consigneename:= SysInfo.LoginUserInfo.UserName;//收货人
        Params.ParamByName('goods.goodsno').Value:= Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];//寄存单号
        consignee := SysInfo.LoginUserInfo.UserID;
         Params.ParamByName('goods.orgid').Value := SysInfo.LoginUserInfo.orgid;
      end;


      Params.ParamByName('goods.num').Value := Trim(nvedtnum.Text);//保管牌号
      Params.ParamByName('goods.customer').Value := Trim(nvedtcustomer.Text);//旅客姓名
      Params.ParamByName('goods.phone').Value := Trim(nvedtphone.Text);//旅客电话
      Params.ParamByName('goods.idcardno').Value := Trim(nvedtidcardno.Text);//身份证
      Params.ParamByName('goods.goodstype').Value := nvcbbgoodstype.GetSelectCode;//小件类别
      Params.ParamByName('goods.pieces').Value := Trim(nvedtpieces.Text);//件数;
      Params.ParamByName('goods.location').Value := Trim(nvedtlocation.Text);//存放地点;
      Params.ParamValues['goods.pickupenddate']:= FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime);//提取截止日期
      Params.ParamByName('goods.custodial').Value := nvedtcustodial.Text;//保管费
      Params.ParamByName('goods.penalty').Value := '0';//滞纳金
      Params.ParamByName('goods.totalfee').Value := nvedtcustodial.Text;//合计金额
      Params.ParamByName('goods.consignee').Value := consignee ;//收货人
      Params.ParamByName('goods.deposittiime').Value := FormatDateTime('yyyy-mm-dd',deposittiime); //寄存时间
      Params.ParamByName('goods.status').Value := '0';//状态（0：库存、1：已提领，2：作废）
      Params.ParamByName('goods.pickuper').Value := '';//提领人
      Params.ParamByName('goods.pickupdate').Value := '';//提领日期
      Params.ParamByName('goods.operator').Value := '';//办理员
      Params.ParamByName('goods.remak').Value := trim(memremarks.Text);//备注

      //createtime:TDateTime;//date	n	sys;//date
      //createby:Integer;//number(10)	n
      //updatetime:TDateTime;//date	n	sys;//date
      //updateby:Integer;//number(10)	n
      bbtnSave.Enabled :=false;
      Execute;
      bbtnSave.Enabled :=true;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        bbtnSave.Enabled :=false;
        if goodsid > 0 then
          result := '修改'
        else
          result := '添加';
        log := result +VarToStr(Params.ParamValues['goodsid'])+ '小件寄存：所属机构='+
        SysInfo.LoginUserInfo.OrgName+ ','+result+'人='+
        SysInfo.LoginUserInfo.UserName+',保管牌号='+nvedtnum.Text+
        ',寄存单号='+nvedtgoodsno.Text+
        ',寄存时间='+FormatDateTime('yyyy-mm-dd',deposittiime)+
        ',旅客姓名='+Trim(nvedtcustomer.Text)+',旅客电话='+Trim(nvedtphone.Text)+
        ',身份证='+nvedtidcardno.Text+ ',小件类别='+nvcbbgoodstype.GetSelectValue+
        ',件数='+nvedtpieces.Text+',存放地点='+nvedtlocation.Text+ ',提取截止日期'
        +FormatDateTime('yyyy-mm-dd', dtppickupenddate.DateTime)+
        ',保管费='+nvedtcustodial.Text;
        SysLog.WriteLog('行包管理->小件寄存',result,log);

        try
          Foperationid := Params.ParamValues['goodsid'];
//          if self.edittype = Tedittype.add then
//          begin
             printpack;
//          end;
        finally
//           if self.edittype = Tedittype.add then
//           begin
               updatepackbill;
//           end;
           self.ModalResult := mrOk;
        end;

      end;
    end;

end;

procedure TFrmPackGoodsAdd.dtppickupenddateChange(Sender: TObject);
var
days:Integer;
goodsdays:Integer;
begin
  inherited;
  if StrToInt(FormatDateTime('yyyyMMdd', dtppickupenddate.DateTime))<StrToInt(FormatDateTime('yyyyMMdd', Now())) then
  begin
    SysDialogs.ShowMessage('提取截止日期不能小于今天!');
    dtppickupenddate.DateTime :=Now();
    dtppickupenddate.SetFocus;
    exit;
  end;
  {goodsdays :=StrToInt(getParametervalue('8011', sysInfo.LoginUserInfo.OrgID));//小件寄存最大寄存天数
  Sysdialogs.ShowMessage(IntToStr(DaysBetween(Now,dtppickupenddate.DateTime)));
  if DaysBetween(Now,dtppickupenddate.DateTime)>=goodsdays-2 then
  begin
    SysDialogs.ShowMessage('寄存天数超过最大寄存天数'+IntToStr(goodsdays)+'天!');
    dtppickupenddate.SetFocus;
    exit;
  end;
  }
//  days :=DaysBetween(Now,dtppickupenddate.DateTime)+1;//存储天数
//  nvedtcustodial.Text := FloatToStr(storagefee*days);//保管费
end;

procedure TFrmPackGoodsAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  if Assigned(printValue) then
//    printValue.Free;
end;

procedure TFrmPackGoodsAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbgoodstype.Active :=true;

end;

procedure TFrmPackGoodsAdd.FormShow(Sender: TObject);

begin
  inherited;
  if self.edittype = Tedittype.update then
  begin
    dtppickupenddate.DateTime :=pickupenddate;
    nvedtnum.Enabled :=false;
    nvedtcustodial.Enabled:= false;
//    dtppickupenddate.Enabled :=false;
    nvedtgoodsno.Text :=goodsno;
  end
  else
  begin
    dtppickupenddate.DateTime :=Now()+1;//StrToInt(getParametervalue('8014', sysInfo.LoginUserInfo.OrgID));//基本费保管截止日期
//    dtppickupenddate.Enabled :=false;
    nvcbbgoodstype.ItemIndex :=0;
    nvedtgoodsno.Text :=Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];
    storagefee :=StrToFloat(getParametervalue('8009', sysInfo.LoginUserInfo.OrgID));//小件寄存基本保管费
    nvedtcustodial.Text := FloatToStr(storagefee);
  end;



end;


procedure TFrmPackGoodsAdd.printpack();

begin
    printValue := TDictionary<String, String>.Create;
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('小件寄存',
        '小件寄存单'));

    printValue.Add('goodsnum', nvedtnum.Text);//保管牌号
    printValue.Add('goodsno', Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill']);//寄存单号
    printValue.Add('customer',nvedtcustomer.Text);//旅客姓名
    printValue.Add('phone', nvedtphone.Text);//旅客电话
    printValue.Add('idcardno', nvedtidcardno.Text);//身份证
    printValue.Add('goodstype', nvcbbgoodstype.Text);//小件类别
    printValue.Add('pieces', nvedtpieces.Text);//件数
    printValue.Add('location', nvedtlocation.Text);//存放位置
    printValue.Add('pickupenddate', FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime));//提取截止日期
    printValue.Add('custodial', nvedtcustodial.Text);// 保管费
    printValue.Add('consignee', consigneename);//收货人

    billPrint.SingleValue := printValue;
    billPrint.Print;
end;

procedure TFrmPackGoodsAdd.updatepackbill();
var billinusestatus,billinusenextno,billinusenextform:string;
begin

   with Sysinfo.LoginUserInfo do
   begin
      billinusenextform := inttostr(strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill']));
      billinusenextno := inttostr(strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'])+ 1);
      curBillNo.AddOrSetValue('GoodsBill',
      zerofill(billinusenextno,
       length(curBillNo.Items['GoodsBill'])));
      curBillNum.AddOrSetValue('GoodsBill',
      curBillNum.Items['GoodsBill'] - 1);
      if curbillnum.items['GoodsBill']>0 then
        billinusestatus :='1'
      else
        billinusestatus :='2';


   end;

   with jcdsupdateBillinuse do
   begin
      Active :=false;
      Params.ParamValues['billinusestatus']:=billinusestatus;
      Params.ParamValues['billinusenextno']:=billinusenextno;
      Params.ParamValues['billinusenextform']:=billinusenextform;
      Params.ParamValues['billtypecode']:='GoodsBill';


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
