unit UFrmGoodsReceive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls,NovaPrint,Generics.Collections;

type
  TFrmGoodsReceive = class(TSimpleEditForm)
    Label17: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label35: TLabel;
    Label1: TLabel;
    Label26: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label2: TLabel;
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
    jcdsQueryGoods: TjsonClientDataSet;
    jcdsQueryGoodsid: TLargeintField;
    jcdsQueryGoodsgoodsno: TWideStringField;
    jcdsQueryGoodsnum: TWideStringField;
    jcdsQueryGoodscustomer: TWideStringField;
    jcdsQueryGoodsphone: TWideStringField;
    jcdsQueryGoodsidcardno: TWideStringField;
    jcdsQueryGoodsGOODSTYPE: TWideStringField;
    jcdsQueryGoodslocation: TWideStringField;
    jcdsQueryGoodspickupenddate: TDateTimeField;
    jcdsQueryGoodsdeposittiime: TDateTimeField;
    jcdsQueryGoodscustodial: TFloatField;
    jcdsQueryGoodspenalty: TFloatField;
    jcdsQueryGoodstotalfee: TFloatField;
    jcdsQueryGoodsconsignee: TLargeintField;
    jcdsQueryGoodsconsigneename: TWideStringField;
    jcdsQueryGoodsSTATUS: TWideStringField;
    jcdsQueryGoodspickuper: TWideStringField;
    jcdsQueryGoodspickupdate: TDateTimeField;
    jcdsQueryGoodsoperator: TLargeintField;
    jcdsQueryGoodsoperatorname: TWideStringField;
    jcdsQueryGoodsremak: TWideStringField;
    jcdsQueryGoodsORGID: TLargeintField;
    jcdsQueryGoodsorgname: TWideStringField;
    jcdsQueryGoodscreatetime: TDateTimeField;
    jcdsQueryGoodscreateby: TLargeintField;
    jcdsQueryGoodsupdatetime: TDateTimeField;
    jcdsQueryGoodsupdateby: TLargeintField;
    jcdsQueryGoodscreatebyname: TWideStringField;
    jcdsQueryGoodsupdatebyname: TWideStringField;
    Label3: TLabel;
    dtppickupdate: TDateTimePicker;
    Label4: TLabel;
    nvedtpenalty: TNovaEdit;
    Label8: TLabel;
    nvedttotalfee: TNovaEdit;
    Label9: TLabel;
    nvedtpickuper: TNovaEdit;
    Label15: TLabel;
    jcdsQueryGoodspieces: TIntegerField;
    nvhelpgoodsno: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtgoodsnoKeyPress(Sender: TObject; var Key: Char);
    procedure nvhelpgoodsnoClick(Sender: TObject);
    procedure nvhelpgoodsnoIdChange(Sender: TObject);
  private
    { Private declarations }
    Foperationid: Integer;
    log:string;
    schedulename,vehiclecodename:string;

    procedure printpack;
    procedure updatepackbill;
    procedure QueryGoods;
    procedure dataNull;
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
  FrmGoodsReceive:TFrmGoodsReceive;

implementation
uses PubFn,DateUtils;
{$R *.dfm}

procedure TFrmGoodsReceive.bbtnSaveClick(Sender: TObject);
var result:string;
begin
  inherited;
  if goodsid <=0 then
    begin
      SysDialogs.ShowMessage('请确认提领单号!');
      //nvedtnum.SetFocus;
      nvhelpgoodsno.SetFocus;
      exit;
    end;

    if Trim(nvedtpickuper.Text) = '' then
    begin
      SysDialogs.ShowMessage('提领人不能为空!');
      nvedtpickuper.SetFocus;
      exit;
    end;

    if StrToFloat(nvedtcustodial.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('保管费金额数值过大');
      nvedtcustodial.Text :='9999.99';
      nvedtcustodial.SetFocus;
      exit;
    end;

    if StrToFloat(nvedtpenalty.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('滞纳金额数值过大');
      nvedtpenalty.Text :='9999.99';
      nvedtpenalty.SetFocus;
      exit;
    end;

    if StrToFloat(nvedttotalfee.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('合计金额数值过大');
      nvedttotalfee.Text :='9999.99';
      nvedttotalfee.SetFocus;
      exit;
    end;

    with jcdsgoodssave do
    begin
      Active :=false;
//      if self.edittype = Tedittype.update then
//      begin
        Params.ParamByName('goods.goodsno').Value:= goodsno;//寄存单号
  //      consignee := consignee;//收货人
        Params.ParamValues['goods.id'] := IntToStr(goodsid);
        Params.ParamValues['goods.createby']:= IntToStr(createby);
        Params.ParamValues['goods.createtime']:= FormatDateTime('yyyy-mm-dd', createtime);
  //      deposittiime := deposittiime;//寄存时间
         Params.ParamByName('goods.orgid').Value := IntToStr(orgid);
//      end
//      else
//      begin
//        deposittiime:=  Now();//寄存时间
//        consigneename:= SysInfo.LoginUserInfo.UserName;//收货人
//        Params.ParamByName('goods.goodsno').Value:= Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];//寄存单号
//        consignee := SysInfo.LoginUserInfo.UserID;
//         Params.ParamByName('goods.orgid').Value := SysInfo.LoginUserInfo.orgid;
//      end;


      Params.ParamByName('goods.num').Value := Trim(nvedtnum.Text);//保管牌号
      Params.ParamByName('goods.customer').Value := Trim(nvedtcustomer.Text);//旅客姓名
      Params.ParamByName('goods.phone').Value := Trim(nvedtphone.Text);//旅客电话
      Params.ParamByName('goods.idcardno').Value := Trim(nvedtidcardno.Text);//身份证
      Params.ParamByName('goods.goodstype').Value := nvcbbgoodstype.GetSelectCode;//小件类别
      Params.ParamByName('goods.pieces').Value := Trim(nvedtpieces.Text);//件数;
      Params.ParamByName('goods.location').Value := Trim(nvedtlocation.Text);//存放地点;
      Params.ParamValues['goods.pickupenddate']:= FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime);//提取截止日期
      Params.ParamByName('goods.custodial').Value := nvedtcustodial.Text;//保管费
      Params.ParamByName('goods.penalty').Value := nvedtpenalty.Text;//滞纳金
      Params.ParamByName('goods.totalfee').Value := nvedttotalfee.Text;//合计金额
      Params.ParamByName('goods.consignee').Value := consignee ;//收货人
      Params.ParamByName('goods.deposittiime').Value := FormatDateTime('yyyy-mm-dd',deposittiime); //寄存时间
      Params.ParamByName('goods.status').Value := '1';//状态（0：库存、1：已提领，2：作废）
      Params.ParamByName('goods.pickuper').Value :=nvedtpickuper.Text ;//提领人
      Params.ParamByName('goods.pickupdate').Value := FormatDateTime('yyyy-mm-dd',Now());//提领日期
      Params.ParamByName('goods.operator').Value := SysInfo.LoginUserInfo.UserID;//办理员
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
        if operationid > 0 then
          result := '领取'
        else
          result := '领取';

        log := result +Params.ParamValues['goodsid']+ '小件寄存：所属机构='+
        SysInfo.LoginUserInfo.OrgName+ ',办理人='+
        SysInfo.LoginUserInfo.UserName+',保管牌号='+nvedtnum.Text+
        ',寄存单号='+nvedtgoodsno.Text+
        ',寄存时间='+FormatDateTime('yyyy-mm-dd',deposittiime)+
        ',旅客姓名='+Trim(nvedtcustomer.Text)+',旅客电话='+Trim(nvedtphone.Text)+
        ',身份证='+nvedtidcardno.Text+ ',小件类别='+nvcbbgoodstype.GetSelectValue+
        ',件数='+nvedtpieces.Text+',存放地点='+nvedtlocation.Text+ ',提取截止日期='
        +FormatDateTime('yyyy-mm-dd', dtppickupenddate.DateTime)+'提领日期='+
        FormatDateTime('yyyy-mm-dd', dtppickupdate.DateTime)+'提领人='+nvedtpickuper.Text+
        ',保管费='+nvedtcustodial.Text+'滞纳金='+nvedtpenalty.Text+',合计金额='+
        nvedttotalfee.Text+ ',收货人='+consigneename;
        SysLog.WriteLog('行包管理->小件寄存',result,log);

        try
          Foperationid := Params.ParamValues['goodsid'];
          if self.edittype = Tedittype.add then
          begin
             printpack;
          end;
        finally
           {if self.edittype = Tedittype.add then
           begin
               updatepackbill;
           end;}
           self.ModalResult := mrOk;
        end;

      end;
    end;

end;

procedure TFrmGoodsReceive.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbgoodstype.Active :=true;

end;

procedure TFrmGoodsReceive.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then
  begin
    nvedtgoodsno.Enabled :=false;
    nvhelpgoodsno.Enabled :=false;
    nvedtpickuper.SetFocus;
  end
  else
  begin
    with nvhelpgoodsno do
    begin
     Params.ParamValues['filter_EQS_g!status'] :='0';
     Params.ParamValues['filter_EQL_g!orgid'] := Sysinfo.LoginUserInfo.OrgID;
    end;
    nvhelpgoodsno.SetFocus;
  end;

end;


procedure TFrmGoodsReceive.nvedtgoodsnoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    QueryGoods;
end;

procedure TFrmGoodsReceive.nvhelpgoodsnoClick(Sender: TObject);
begin
  inherited;
  with nvhelpgoodsno do
  begin
     Params.ParamValues['filter_EQS_g!status'] :='0';
     Params.ParamValues['filter_EQL_g!orgid'] := Sysinfo.LoginUserInfo.OrgID;
  end;
end;

procedure TFrmGoodsReceive.nvhelpgoodsnoIdChange(Sender: TObject);
begin
  inherited;
  if (nvhelpgoodsno.Text<>'') or (nvhelpgoodsno.Id>0) then
    QueryGoods
  else
  begin
       dataNull;
  end;

end;

procedure TFrmGoodsReceive.printpack();
var billPrint: TNovaPrint;
   printValue: TDictionary<String, String>; // 输出单变量
begin
    printValue := TDictionary<String, String>.Create;
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('小件领取单',
        '小件领取单'));

    printValue.Add('goodsnum', nvedtnum.Text);//保管牌号
    printValue.Add('goodsno', goodsno);//寄存单号
    printValue.Add('customer',nvedtcustomer.Text);//旅客姓名
    printValue.Add('phone', nvedtphone.Text);//旅客电话
    printValue.Add('idcardno', nvedtidcardno.Text);//身份证
    printValue.Add('goodstype', nvcbbgoodstype.Text);//小件类别
    printValue.Add('pieces', nvedtpieces.Text);//件数
//    printValue.Add('location', nvedtlocation.Text);//存放位置
    printValue.Add('pickupenddate', FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime));//提取截止日期
    printValue.Add('pickupdate', FormatDateTime('yyyy-MM-dd', dtppickupdate.DateTime));//提领日期
    printValue.Add('custodial', nvedtcustodial.Text);// 保管费
//    printValue.Add('consignee', consigneename);//收货人
    printValue.Add('pickuper', nvedtpickuper.Text);//提领人
    printValue.Add('operator', SysInfo.LoginUserInfo.UserName);//办理员
    printValue.Add('penalty', nvedtpenalty.Text);// 滞纳金
     printValue.Add('totalfee', nvedttotalfee.Text);// 合计金额

    billPrint.SingleValue := printValue;
    billPrint.Print;
end;

procedure TFrmGoodsReceive.updatepackbill();
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

      if curBillNum.Items['GoodsBill']>0 then
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

procedure TFrmGoodsReceive.QueryGoods();
var days:Integer;
 storagefeemoney,daymoney,penaltymoney:Double;
begin
  if Trim(nvhelpgoodsno.Text)='' then
  begin
    SysDialogs.ShowMessage('请确认提领单号!');
    nvhelpgoodsno.SetFocus;
    exit;
  end;

  with jcdsQueryGoods do
  begin
    Active:=false;
    Params.ParamValues['filter_EQS_g!goodsno'] := Trim(nvhelpgoodsno.Text);
    Params.ParamValues['filter_EQS_g!status'] :='0';
    Params.ParamValues['filter_INS_g!orgid'] := Sysinfo.LoginUserInfo.OrgID;
    Active :=true;
    if jcdsQueryGoods.RecNo <= 0 then
    begin
       SysDialogs.ShowMessage('没有该提领单号的小件信息!');

       dataNull;
       exit;
    end;
    while not eof do
    begin
      goodsid := FieldByName('id').AsInteger;
      goodsno := FieldByName('goodsno').AsString;
      createby := FieldByName('createby').AsInteger;
      createtime := FieldByName('createtime').AsDateTime;

      consigneename :=FieldByName('consigneename').AsString;;//收货人
      consignee :=FieldByName('consignee').AsInteger;//收货人
      deposittiime :=FieldByName('deposittiime').AsDateTime; //寄存时间
      memremarks.Text :=FieldByName('remak').AsString;//备注
      orgid :=FieldByName('orgid').AsInteger;

//      nvedtgoodsno.Text := FieldByName('goodsno').AsString;//寄存单号
      dtppickupenddate.DateTime :=FieldByName('pickupenddate').AsDateTime;//提取截止日期
      nvedtnum.Text :=FieldByName('num').AsString;//保管牌号
      nvedtcustomer.Text :=FieldByName('customer').AsString;//旅客姓名
      nvedtphone.Text :=FieldByName('phone').AsString;//旅客电话
      nvedtidcardno.Text :=FieldByName('idcardno').AsString;//身份证
      nvcbbgoodstype.SetItemIndexByCode(FieldByName('goodstype').AsString);//小件类别
      nvedtpieces.Text :=FieldByName('pieces').AsString;//件数;
      nvedtlocation.Text :=FieldByName('location').AsString;//存放地点;
      nvedtcustodial.Text :=FieldByName('custodial').AsString;//保管费

      storagefeemoney :=StrToFloat(nvedtcustodial.Text);//保管费
      dtppickupdate.DateTime :=Now();//提领日期

      if formatdatetime('yyyyMMdd',
       dtppickupenddate.DateTime) < formatdatetime
        ('yyyyMMdd', Now) then
      begin
      //当提取截止日期小于提领日期
        daymoney :=StrToFloat(getParametervalue('8010', sysInfo.LoginUserInfo.OrgID));//每天的滞纳金
        days :=DaysBetween(Now,dtppickupenddate.DateTime);//超期天数
        penaltymoney:= daymoney*days;// 滞纳金
      end;



      nvedtpenalty.Text :=FloatToStr(penaltymoney);
      nvedttotalfee.Text :=FloatToStr(penaltymoney+storagefeemoney);//合计金额

      nvedtpickuper.Text := nvedtcustomer.Text; //提领人

      Next;
    end;

  end;
end;
procedure TFrmGoodsReceive.dataNull();
begin
     goodsid :=0;
       //nvedtgoodsno.SetFocus;
       nvhelpgoodsno.SetFocus;
//       nvedtgoodsno.Text := '';//寄存单号
       dtppickupenddate.DateTime :=Now();//提取截止日期
       nvedtnum.Text :='';//保管牌号
       nvedtcustomer.Text :='';//旅客姓名
       nvedtphone.Text :='';//旅客电话
       nvedtidcardno.Text :='';//身份证
       nvcbbgoodstype.ItemIndex :=0;//小件类别
       nvedtpieces.Text :='0';//件数;
       nvedtlocation.Text :='';//存放地点;
       nvedtcustodial.Text :='0';//保管费
       nvedtpenalty.Text :='0';
       nvedttotalfee.Text :='0';//合计金额

       nvedtpickuper.Text := ''; //提领人
end;
end.
