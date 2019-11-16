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
    printValue: TDictionary<String, String>; // ���������
    procedure printpack;
    procedure updatepackbill;
  public
    { Public declarations }
  goodsid:Integer;
  goodsno:string;//varchar2(20)y�Ĵ浥��
  num:string;//varchar2(10)y�����ƺ�
  customer:string;//varchar2(20)y�ÿ�����
  phone:string;//varchar2(20)y�ÿ͵绰
  idcardno:string;//varchar2(20)y���֤
  goodstype:string;//varchar2(10)yС�����:��0��ֽ�䡢1�������2��������3�������䣩ȡ�����ֵ�
  pieces:Integer;//number(5)y����
  location:string;//varchar2(20)y���λ��
  pickupenddate:TDateTime;//date��ȡ��ֹ����
  deposittiime:TDateTime;//date�Ĵ�ʱ��
  custodial:Double;//number(6,2)y���ܷ�
  penalty:Double;//number(6,2)y���ɽ�
  totalfee:Double;//number(6,2)y�ϼƽ��
  consignee:Integer;//number(10)y�ջ���
  consigneename:string;
  status:string;//varchar2(10)y״̬��0����桢1�������죬2�����ϣ�
  pickuper:string;//varchar2(30)y������
  pickupdate:TDateTime;//date��������
  operatorby:Integer;//number(10)y����Ա
  remak:string;//varchar2(50)y��ע
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
      SysDialogs.ShowMessage('�����ƺŲ���Ϊ��!');
      nvedtnum.SetFocus;
      exit;
    end;

    if Trim(nvedtcustomer.Text) = '' then
    begin
      SysDialogs.ShowMessage('�ÿ���������Ϊ��!');
      nvedtnum.SetFocus;
      exit;
    end;

    if Trim(nvedtphone.Text) = '' then
    begin
      SysDialogs.ShowMessage('�ÿ͵绰����Ϊ��!');
      nvedtphone.SetFocus;
      exit;
    end;
    {
    if Trim(nvedtidcardno.Text) = '' then
    begin
      SysDialogs.ShowMessage('���֤����Ϊ��!');
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
      SysDialogs.ShowMessage('��ѡ��С�����!');
      nvcbbgoodstype.SetFocus;
      exit;
    end;

    if (Trim(nvedtpieces.Text) = '') then
    begin
      SysDialogs.ShowMessage('��������Ϊ��!');
      nvedtpieces.Text :='1';
      nvedtpieces.SetFocus;
      exit;
    end;

    if StrToInt(FormatDateTime('yyyyMMdd', dtppickupenddate.DateTime))<StrToInt(FormatDateTime('yyyyMMdd', Now())) then
    begin
      SysDialogs.ShowMessage('��ȡ��ֹ���ڲ���С�ڽ���!');
      dtppickupenddate.SetFocus;
      exit;
    end;

    if StrToFloat(nvedtcustodial.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('���ܷѽ����ֵ������Χ(0~9999.99)!');
      nvedtcustodial.SetFocus;
      exit;
    end;


    with jcdsgoodssave do
    begin
      Active :=false;
      if self.edittype = Tedittype.update then
      begin
        Params.ParamByName('goods.goodsno').Value:= Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];//goodsno;//�Ĵ浥��
  //      consignee := consignee;//�ջ���
        Params.ParamValues['goods.id'] := IntToStr(goodsid);
        Params.ParamValues['goods.createby']:= IntToStr(createby);
        Params.ParamValues['goods.createtime']:= FormatDateTime('yyyy-mm-dd HH:mm:ss', createtime);
  //      deposittiime := deposittiime;//�Ĵ�ʱ��
         Params.ParamByName('goods.orgid').Value := IntToStr(orgid);
      end
      else
      begin
        deposittiime:=  Now();//�Ĵ�ʱ��
        consigneename:= SysInfo.LoginUserInfo.UserName;//�ջ���
        Params.ParamByName('goods.goodsno').Value:= Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];//�Ĵ浥��
        consignee := SysInfo.LoginUserInfo.UserID;
         Params.ParamByName('goods.orgid').Value := SysInfo.LoginUserInfo.orgid;
      end;


      Params.ParamByName('goods.num').Value := Trim(nvedtnum.Text);//�����ƺ�
      Params.ParamByName('goods.customer').Value := Trim(nvedtcustomer.Text);//�ÿ�����
      Params.ParamByName('goods.phone').Value := Trim(nvedtphone.Text);//�ÿ͵绰
      Params.ParamByName('goods.idcardno').Value := Trim(nvedtidcardno.Text);//���֤
      Params.ParamByName('goods.goodstype').Value := nvcbbgoodstype.GetSelectCode;//С�����
      Params.ParamByName('goods.pieces').Value := Trim(nvedtpieces.Text);//����;
      Params.ParamByName('goods.location').Value := Trim(nvedtlocation.Text);//��ŵص�;
      Params.ParamValues['goods.pickupenddate']:= FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime);//��ȡ��ֹ����
      Params.ParamByName('goods.custodial').Value := nvedtcustodial.Text;//���ܷ�
      Params.ParamByName('goods.penalty').Value := '0';//���ɽ�
      Params.ParamByName('goods.totalfee').Value := nvedtcustodial.Text;//�ϼƽ��
      Params.ParamByName('goods.consignee').Value := consignee ;//�ջ���
      Params.ParamByName('goods.deposittiime').Value := FormatDateTime('yyyy-mm-dd',deposittiime); //�Ĵ�ʱ��
      Params.ParamByName('goods.status').Value := '0';//״̬��0����桢1�������죬2�����ϣ�
      Params.ParamByName('goods.pickuper').Value := '';//������
      Params.ParamByName('goods.pickupdate').Value := '';//��������
      Params.ParamByName('goods.operator').Value := '';//����Ա
      Params.ParamByName('goods.remak').Value := trim(memremarks.Text);//��ע

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
          result := '�޸�'
        else
          result := '���';
        log := result +VarToStr(Params.ParamValues['goodsid'])+ 'С���Ĵ棺��������='+
        SysInfo.LoginUserInfo.OrgName+ ','+result+'��='+
        SysInfo.LoginUserInfo.UserName+',�����ƺ�='+nvedtnum.Text+
        ',�Ĵ浥��='+nvedtgoodsno.Text+
        ',�Ĵ�ʱ��='+FormatDateTime('yyyy-mm-dd',deposittiime)+
        ',�ÿ�����='+Trim(nvedtcustomer.Text)+',�ÿ͵绰='+Trim(nvedtphone.Text)+
        ',���֤='+nvedtidcardno.Text+ ',С�����='+nvcbbgoodstype.GetSelectValue+
        ',����='+nvedtpieces.Text+',��ŵص�='+nvedtlocation.Text+ ',��ȡ��ֹ����'
        +FormatDateTime('yyyy-mm-dd', dtppickupenddate.DateTime)+
        ',���ܷ�='+nvedtcustodial.Text;
        SysLog.WriteLog('�а�����->С���Ĵ�',result,log);

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
    SysDialogs.ShowMessage('��ȡ��ֹ���ڲ���С�ڽ���!');
    dtppickupenddate.DateTime :=Now();
    dtppickupenddate.SetFocus;
    exit;
  end;
  {goodsdays :=StrToInt(getParametervalue('8011', sysInfo.LoginUserInfo.OrgID));//С���Ĵ����Ĵ�����
  Sysdialogs.ShowMessage(IntToStr(DaysBetween(Now,dtppickupenddate.DateTime)));
  if DaysBetween(Now,dtppickupenddate.DateTime)>=goodsdays-2 then
  begin
    SysDialogs.ShowMessage('�Ĵ������������Ĵ�����'+IntToStr(goodsdays)+'��!');
    dtppickupenddate.SetFocus;
    exit;
  end;
  }
//  days :=DaysBetween(Now,dtppickupenddate.DateTime)+1;//�洢����
//  nvedtcustodial.Text := FloatToStr(storagefee*days);//���ܷ�
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
    dtppickupenddate.DateTime :=Now()+1;//StrToInt(getParametervalue('8014', sysInfo.LoginUserInfo.OrgID));//�����ѱ��ܽ�ֹ����
//    dtppickupenddate.Enabled :=false;
    nvcbbgoodstype.ItemIndex :=0;
    nvedtgoodsno.Text :=Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];
    storagefee :=StrToFloat(getParametervalue('8009', sysInfo.LoginUserInfo.OrgID));//С���Ĵ�������ܷ�
    nvedtcustodial.Text := FloatToStr(storagefee);
  end;



end;


procedure TFrmPackGoodsAdd.printpack();

begin
    printValue := TDictionary<String, String>.Create;
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('С���Ĵ�',
        'С���Ĵ浥'));

    printValue.Add('goodsnum', nvedtnum.Text);//�����ƺ�
    printValue.Add('goodsno', Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill']);//�Ĵ浥��
    printValue.Add('customer',nvedtcustomer.Text);//�ÿ�����
    printValue.Add('phone', nvedtphone.Text);//�ÿ͵绰
    printValue.Add('idcardno', nvedtidcardno.Text);//���֤
    printValue.Add('goodstype', nvcbbgoodstype.Text);//С�����
    printValue.Add('pieces', nvedtpieces.Text);//����
    printValue.Add('location', nvedtlocation.Text);//���λ��
    printValue.Add('pickupenddate', FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime));//��ȡ��ֹ����
    printValue.Add('custodial', nvedtcustodial.Text);// ���ܷ�
    printValue.Add('consignee', consigneename);//�ջ���

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
