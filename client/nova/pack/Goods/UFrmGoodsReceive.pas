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
      SysDialogs.ShowMessage('��ȷ�����쵥��!');
      //nvedtnum.SetFocus;
      nvhelpgoodsno.SetFocus;
      exit;
    end;

    if Trim(nvedtpickuper.Text) = '' then
    begin
      SysDialogs.ShowMessage('�����˲���Ϊ��!');
      nvedtpickuper.SetFocus;
      exit;
    end;

    if StrToFloat(nvedtcustodial.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('���ܷѽ����ֵ����');
      nvedtcustodial.Text :='9999.99';
      nvedtcustodial.SetFocus;
      exit;
    end;

    if StrToFloat(nvedtpenalty.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('���ɽ����ֵ����');
      nvedtpenalty.Text :='9999.99';
      nvedtpenalty.SetFocus;
      exit;
    end;

    if StrToFloat(nvedttotalfee.Text)>=10000 then
    begin
      SysDialogs.ShowMessage('�ϼƽ����ֵ����');
      nvedttotalfee.Text :='9999.99';
      nvedttotalfee.SetFocus;
      exit;
    end;

    with jcdsgoodssave do
    begin
      Active :=false;
//      if self.edittype = Tedittype.update then
//      begin
        Params.ParamByName('goods.goodsno').Value:= goodsno;//�Ĵ浥��
  //      consignee := consignee;//�ջ���
        Params.ParamValues['goods.id'] := IntToStr(goodsid);
        Params.ParamValues['goods.createby']:= IntToStr(createby);
        Params.ParamValues['goods.createtime']:= FormatDateTime('yyyy-mm-dd', createtime);
  //      deposittiime := deposittiime;//�Ĵ�ʱ��
         Params.ParamByName('goods.orgid').Value := IntToStr(orgid);
//      end
//      else
//      begin
//        deposittiime:=  Now();//�Ĵ�ʱ��
//        consigneename:= SysInfo.LoginUserInfo.UserName;//�ջ���
//        Params.ParamByName('goods.goodsno').Value:= Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];//�Ĵ浥��
//        consignee := SysInfo.LoginUserInfo.UserID;
//         Params.ParamByName('goods.orgid').Value := SysInfo.LoginUserInfo.orgid;
//      end;


      Params.ParamByName('goods.num').Value := Trim(nvedtnum.Text);//�����ƺ�
      Params.ParamByName('goods.customer').Value := Trim(nvedtcustomer.Text);//�ÿ�����
      Params.ParamByName('goods.phone').Value := Trim(nvedtphone.Text);//�ÿ͵绰
      Params.ParamByName('goods.idcardno').Value := Trim(nvedtidcardno.Text);//���֤
      Params.ParamByName('goods.goodstype').Value := nvcbbgoodstype.GetSelectCode;//С�����
      Params.ParamByName('goods.pieces').Value := Trim(nvedtpieces.Text);//����;
      Params.ParamByName('goods.location').Value := Trim(nvedtlocation.Text);//��ŵص�;
      Params.ParamValues['goods.pickupenddate']:= FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime);//��ȡ��ֹ����
      Params.ParamByName('goods.custodial').Value := nvedtcustodial.Text;//���ܷ�
      Params.ParamByName('goods.penalty').Value := nvedtpenalty.Text;//���ɽ�
      Params.ParamByName('goods.totalfee').Value := nvedttotalfee.Text;//�ϼƽ��
      Params.ParamByName('goods.consignee').Value := consignee ;//�ջ���
      Params.ParamByName('goods.deposittiime').Value := FormatDateTime('yyyy-mm-dd',deposittiime); //�Ĵ�ʱ��
      Params.ParamByName('goods.status').Value := '1';//״̬��0����桢1�������죬2�����ϣ�
      Params.ParamByName('goods.pickuper').Value :=nvedtpickuper.Text ;//������
      Params.ParamByName('goods.pickupdate').Value := FormatDateTime('yyyy-mm-dd',Now());//��������
      Params.ParamByName('goods.operator').Value := SysInfo.LoginUserInfo.UserID;//����Ա
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
        if operationid > 0 then
          result := '��ȡ'
        else
          result := '��ȡ';

        log := result +Params.ParamValues['goodsid']+ 'С���Ĵ棺��������='+
        SysInfo.LoginUserInfo.OrgName+ ',������='+
        SysInfo.LoginUserInfo.UserName+',�����ƺ�='+nvedtnum.Text+
        ',�Ĵ浥��='+nvedtgoodsno.Text+
        ',�Ĵ�ʱ��='+FormatDateTime('yyyy-mm-dd',deposittiime)+
        ',�ÿ�����='+Trim(nvedtcustomer.Text)+',�ÿ͵绰='+Trim(nvedtphone.Text)+
        ',���֤='+nvedtidcardno.Text+ ',С�����='+nvcbbgoodstype.GetSelectValue+
        ',����='+nvedtpieces.Text+',��ŵص�='+nvedtlocation.Text+ ',��ȡ��ֹ����='
        +FormatDateTime('yyyy-mm-dd', dtppickupenddate.DateTime)+'��������='+
        FormatDateTime('yyyy-mm-dd', dtppickupdate.DateTime)+'������='+nvedtpickuper.Text+
        ',���ܷ�='+nvedtcustodial.Text+'���ɽ�='+nvedtpenalty.Text+',�ϼƽ��='+
        nvedttotalfee.Text+ ',�ջ���='+consigneename;
        SysLog.WriteLog('�а�����->С���Ĵ�',result,log);

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
   printValue: TDictionary<String, String>; // ���������
begin
    printValue := TDictionary<String, String>.Create;
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('С����ȡ��',
        'С����ȡ��'));

    printValue.Add('goodsnum', nvedtnum.Text);//�����ƺ�
    printValue.Add('goodsno', goodsno);//�Ĵ浥��
    printValue.Add('customer',nvedtcustomer.Text);//�ÿ�����
    printValue.Add('phone', nvedtphone.Text);//�ÿ͵绰
    printValue.Add('idcardno', nvedtidcardno.Text);//���֤
    printValue.Add('goodstype', nvcbbgoodstype.Text);//С�����
    printValue.Add('pieces', nvedtpieces.Text);//����
//    printValue.Add('location', nvedtlocation.Text);//���λ��
    printValue.Add('pickupenddate', FormatDateTime('yyyy-MM-dd', dtppickupenddate.DateTime));//��ȡ��ֹ����
    printValue.Add('pickupdate', FormatDateTime('yyyy-MM-dd', dtppickupdate.DateTime));//��������
    printValue.Add('custodial', nvedtcustodial.Text);// ���ܷ�
//    printValue.Add('consignee', consigneename);//�ջ���
    printValue.Add('pickuper', nvedtpickuper.Text);//������
    printValue.Add('operator', SysInfo.LoginUserInfo.UserName);//����Ա
    printValue.Add('penalty', nvedtpenalty.Text);// ���ɽ�
     printValue.Add('totalfee', nvedttotalfee.Text);// �ϼƽ��

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
    SysDialogs.ShowMessage('��ȷ�����쵥��!');
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
       SysDialogs.ShowMessage('û�и����쵥�ŵ�С����Ϣ!');

       dataNull;
       exit;
    end;
    while not eof do
    begin
      goodsid := FieldByName('id').AsInteger;
      goodsno := FieldByName('goodsno').AsString;
      createby := FieldByName('createby').AsInteger;
      createtime := FieldByName('createtime').AsDateTime;

      consigneename :=FieldByName('consigneename').AsString;;//�ջ���
      consignee :=FieldByName('consignee').AsInteger;//�ջ���
      deposittiime :=FieldByName('deposittiime').AsDateTime; //�Ĵ�ʱ��
      memremarks.Text :=FieldByName('remak').AsString;//��ע
      orgid :=FieldByName('orgid').AsInteger;

//      nvedtgoodsno.Text := FieldByName('goodsno').AsString;//�Ĵ浥��
      dtppickupenddate.DateTime :=FieldByName('pickupenddate').AsDateTime;//��ȡ��ֹ����
      nvedtnum.Text :=FieldByName('num').AsString;//�����ƺ�
      nvedtcustomer.Text :=FieldByName('customer').AsString;//�ÿ�����
      nvedtphone.Text :=FieldByName('phone').AsString;//�ÿ͵绰
      nvedtidcardno.Text :=FieldByName('idcardno').AsString;//���֤
      nvcbbgoodstype.SetItemIndexByCode(FieldByName('goodstype').AsString);//С�����
      nvedtpieces.Text :=FieldByName('pieces').AsString;//����;
      nvedtlocation.Text :=FieldByName('location').AsString;//��ŵص�;
      nvedtcustodial.Text :=FieldByName('custodial').AsString;//���ܷ�

      storagefeemoney :=StrToFloat(nvedtcustodial.Text);//���ܷ�
      dtppickupdate.DateTime :=Now();//��������

      if formatdatetime('yyyyMMdd',
       dtppickupenddate.DateTime) < formatdatetime
        ('yyyyMMdd', Now) then
      begin
      //����ȡ��ֹ����С����������
        daymoney :=StrToFloat(getParametervalue('8010', sysInfo.LoginUserInfo.OrgID));//ÿ������ɽ�
        days :=DaysBetween(Now,dtppickupenddate.DateTime);//��������
        penaltymoney:= daymoney*days;// ���ɽ�
      end;



      nvedtpenalty.Text :=FloatToStr(penaltymoney);
      nvedttotalfee.Text :=FloatToStr(penaltymoney+storagefeemoney);//�ϼƽ��

      nvedtpickuper.Text := nvedtcustomer.Text; //������

      Next;
    end;

  end;
end;
procedure TFrmGoodsReceive.dataNull();
begin
     goodsid :=0;
       //nvedtgoodsno.SetFocus;
       nvhelpgoodsno.SetFocus;
//       nvedtgoodsno.Text := '';//�Ĵ浥��
       dtppickupenddate.DateTime :=Now();//��ȡ��ֹ����
       nvedtnum.Text :='';//�����ƺ�
       nvedtcustomer.Text :='';//�ÿ�����
       nvedtphone.Text :='';//�ÿ͵绰
       nvedtidcardno.Text :='';//���֤
       nvcbbgoodstype.ItemIndex :=0;//С�����
       nvedtpieces.Text :='0';//����;
       nvedtlocation.Text :='';//��ŵص�;
       nvedtcustodial.Text :='0';//���ܷ�
       nvedtpenalty.Text :='0';
       nvedttotalfee.Text :='0';//�ϼƽ��

       nvedtpickuper.Text := ''; //������
end;
end.
