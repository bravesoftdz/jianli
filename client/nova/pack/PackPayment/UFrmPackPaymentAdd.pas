unit UFrmPackPaymentAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls,NovaPrint,Generics.Collections;

type
  TFrmPackPaymentAdd = class(TSimpleEditForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    jcdsdistance: TjsonClientDataSet;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    jcdsquerypackfee: TjsonClientDataSet;
    wdstrngfldResultshowvalue: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    lblsendpack: TLabel;
    lblsendpackmount: TLabel;
    Label51: TLabel;
    lblpickpackmount: TLabel;
    lblpickup: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    nvedtsendpacks: TNovaEdit;
    nvedtsendpackamount: TNovaEdit;
    nvedtpackmoneypayable: TNovaEdit;
    nvedtpickupamount: TNovaEdit;
    nvedtpickups: TNovaEdit;
    nvedtsellby: TNovaEdit;
    nvedtorgname: TNovaEdit;
    Label4: TLabel;
    nvedtactupmoney: TNovaEdit;
    lbl4: TLabel;
    dtpupmoneydate: TDateTimePicker;
    Label5: TLabel;
    dtpreceipttime: TDateTimePicker;
    memremarks: TMemo;
    Label6: TLabel;
    Label30: TLabel;
    Label10: TLabel;
    nvedtlost: TNovaEdit;
    Label11: TLabel;
    jcdspacktturnoverAllSave: TjsonClientDataSet;
    Label2: TLabel;
    nvedtpackstrike: TNovaEdit;
    Label3: TLabel;
    nvedtmoneypayable: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvedtactupmoneyChange(Sender: TObject);
    procedure nvedtpackstrikeChange(Sender: TObject);


  private
    { Private declarations }
    Foperationid: Integer;
    log:string;
    procedure PrintClink;

  public
    { Public declarations }
  pactturnoverdetailid:string;
  packtturnoverid:Integer;//	number(10)	n
  upmoneydate:TDateTime;//	date	n			Ӫ������
  sellby:Integer;//	number(10)	n			����Ա
  sendpacks:Integer;//	number(6)	y			�������
  sendpackamount:Double;//	number(10,2)	n			����Ӫ��
  pickups:Integer;//	number(6)	y			�������
  pickupamount:Double;//	number(10,2)	y			����Ӫ��
  goods:Integer;//	number(6)	y			�Ĵ����
  goodsamount:Double;//	number(10,2)	y			�Ĵ�Ӫ��
  moneypayable:Double;//	number(10,2)	y			Ӧ�ɿ�
  actupmoney:Double;//	number(10,2)	y			ʵ�ɿ�
  receiver:Integer;//	number(10)	y			�տ���id
  receipttime:TDateTime;//	date	y			�տ�ʱ��
  receiptip:string;//	varchar2(20)	y			�տ�ip
  remak:string;//	varchar2(50)	y			��ע
  orgid:Integer;//	number(10)	y			��վ����id
  createtime:TDateTime;//	date	n	sysdate
  createby:Integer;//	number(10)	n
  updatetime:TDateTime;//	date	n	sysdate
  updateby:Integer;//	number(10)	n

  //�������һ��ɿ�
  as_sendpacks,as_pickups,as_depositpieces,as_recaptionspieces,
  as_sendpackamount,as_pickupamount,as_goodsamount,as_moneypayable,
  as_upmoneydate,as_lastlost:string;

  packdatafrom:integer; //������Դ

  property operationid: Integer read Foperationid;
  procedure actupmoneyvalue;
  end;

var
  FrmPackPaymentAdd: TFrmPackPaymentAdd;

implementation
uses PubFn,DateUtils;
{$R *.dfm}

procedure TFrmPackPaymentAdd.bbtnSaveClick(Sender: TObject);

var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result:string;
  packstatus:string;
  packstatusvalue:string;
  ynum:Integer;
begin
  inherited;

  if (Trim(nvedtsendpacks.Text) <> '') then
  begin
    if StrToFloat(nvedtsendpacks.Text)>=1000000 then
    begin
      SysDialogs.ShowMessage('���������ֵ������Χ(0~999999)!');
      nvedtsendpacks.Text :='999999';
      nvedtsendpacks.SetFocus;
      exit;
    end;
  end;

  if (Trim(nvedtsendpackamount.Text) <> '') then
  begin
    if StrToFloat(nvedtsendpackamount.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('��������ֵ������Χ(0~99999999.99)!');
      nvedtsendpackamount.Text :='99999999.99';
      nvedtsendpackamount.SetFocus;
      exit;
    end;
  end;


  if (Trim(nvedtpickups.Text) <> '') then
  begin
    if StrToFloat(nvedtpickups.Text)>=1000000 then
    begin
      SysDialogs.ShowMessage('���������ֵ������Χ(0~999999)!');
      nvedtpickups.Text :='999999';
      nvedtpickups.SetFocus;
      exit;
    end;
  end;

  if (Trim(nvedtpickupamount.Text) <> '') then
  begin
    if StrToFloat(nvedtpickupamount.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('��������ֵ������Χ(0~99999999.99)!');
      nvedtpickupamount.Text :='99999999.99';
      nvedtpickupamount.SetFocus;
      exit;
    end;
  end;

  if (Trim(nvedtmoneypayable.Text) <> '') then
  begin
    if StrToFloat(nvedtmoneypayable.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('Ӧ�ɿ�����ֵ������Χ(0~99999999.99)!');
      nvedtmoneypayable.SetFocus;
      nvedtmoneypayable.Text :='99999999.99';
      exit;
    end;
  end;

  if trim(nvedtactupmoney.Text)='' then
  begin
    SysDialogs.ShowMessage('ʵ�ɿ��Ϊ��');
    nvedtactupmoney.Text :=nvedtmoneypayable.Text;
    nvedtactupmoney.SetFocus;
    exit;
  end;

  if (Trim(nvedtactupmoney.Text) <> '') then
  begin
    if StrToFloat(nvedtmoneypayable.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('ʵ�ɿ�����ֵ������Χ(0~99999999.99)!');
      nvedtactupmoney.SetFocus;
      nvedtactupmoney.Text :='99999999.99';
      exit;
    end;
  end;

  with jcdspacktturnoverAllSave do
  begin
    Active :=false;
    if self.edittype = Tedittype.update then
    begin
//      Params.ParamValues['packtturnover.id'] := IntToStr(packtturnoverid);
//      Params.ParamValues['packtturnover.createby']:= IntToStr(createby);
//      Params.ParamValues['packtturnover.createtime']:= FormatDateTime('yyyy-mm-dd HH:mm:ss', createtime);
    end ;

    Params.ParamByName('packtturnover.upmoneydate').Value := FormatDateTime
      ('yyyy-mm-dd', dtpupmoneydate.DateTime);//Ӫ������
    Params.ParamByName('packtturnover.sellby').Value := IntToStr(nvedtsellby.Id);//	����Ա
    Params.ParamByName('packtturnover.sendpacks').Value := nvedtsendpacks.Text;//�������
    Params.ParamByName('packtturnover.sendpackamount').Value := nvedtsendpackamount.Text;//������
    Params.ParamByName('packtturnover.pickups').Value := nvedtpickups.Text;//�������
    Params.ParamByName('packtturnover.pickupamount').Value := nvedtpickupamount.Text;//������

    Params.ParamByName('packtturnover.moneypayable').Value := nvedtmoneypayable.Text;//Ӧ�ɿ�
    Params.ParamByName('packtturnover.actupmoney').Value := trim(nvedtactupmoney.Text);//ʵ�ɿ�

    Params.ParamByName('packtturnover.lost').Value := trim(nvedtlost.Text);//������Ƿ��
    Params.ParamByName('packtturnover.receiver').Value := IntToStr(SysInfo.LoginUserInfo.UserID);//�տ���
    Params.ParamByName('packtturnover.receipttime').Value := FormatDateTime('yyyy-mm-dd', dtpreceipttime.DateTime);//�տ�ʱ��
    Params.ParamByName('packtturnover.receiptip').Value := '';//�տ�ip
    Params.ParamByName('packtturnover.remak').Value := trim(memremarks.Text);//��ע
    Params.ParamValues['packtturnover.orgid']:= IntToStr(SysInfo.LoginUserInfo.OrgID);//��վ����

    Params.ParamValues['pactturnoverdetailid']:= pactturnoverdetailid;// �а��ɿ���ϸ��ID

    Params.ParamValues['packtturnover.packstrike']:= nvedtpackstrike.Text;//�а�����

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
      if packtturnoverid > 0 then
        result := '�޸�'
      else
        result := '���';
      log := result +VarToStr(Params.ParamValues['packtturnoverid'])+ '�а��ɿ��ǰ����='+SysInfo.LoginUserInfo.OrgName+
      ',Ӫ������='+FormatDateTime('yyyy-mm-dd', dtpupmoneydate.DateTime)+
       ',����Ա='+nvedtsellby.Text+
      ',�������='+nvedtsendpacks.Text+',������='+nvedtsendpackamount.Text+
      ',�������='+nvedtpickups.Text+',������='+nvedtsendpackamount.Text+
      ',Ӧ�ɿ�='+nvedtmoneypayable.Text+',ʵ�ɿ�='+nvedtactupmoney.Text+
       ',������Ƿ��='+nvedtlost.Text+
       ',�տ���='+SysInfo.LoginUserInfo.UserName+',��ע='+memremarks.Text;
      SysLog.WriteLog('�а�����->�а��ɿ�',result,log);

      self.ModalResult := mrOk;

      PrintClink;

    end;

    Foperationid := Params.ParamValues['packtturnoverid'];

  end;

end;

procedure TFrmPackPaymentAdd.nvedtactupmoneyChange(Sender: TObject);
begin
// actupmoneyvalue();
 nvedtlost.Text :=FloatToStr(StrToFloat(nvedtmoneypayable.Text)-StrToFloat(nvedtactupmoney.Text));
end;

procedure TFrmPackPaymentAdd.nvedtpackstrikeChange(Sender: TObject);
begin
  inherited;
    nvedtmoneypayable.Text:= CurrToStr(StrToCurrDef(nvedtpackmoneypayable.Text,0) - StrToCurrDef(nvedtpackstrike.Text,0));
end;

procedure TFrmPackPaymentAdd.actupmoneyvalue();
var actupmoney,moneypayable:Double;
begin
  inherited;
  actupmoney :=StrToFloat(nvedtactupmoney.Text);
//  if StrToFloat(nvedtmoneypayable.Text)<StrToFloat(nvedtlastlost.Text) then
//  begin
//     moneypayable := 0;

//  end
//  else
//  begin
//     moneypayable := StrToFloat(nvedtmoneypayable.Text)-StrToFloat(nvedtlastlost.Text);
//     nvedtlost.Text :=FloatToStr(actupmoney-moneypayable);
//  end;

end;

procedure TFrmPackPaymentAdd.PrintClink();
var billPrint: TNovaPrint;
   printValue: TDictionary<String, String>; // ���������
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('�а��ɿ',
      '�а��ɿ'));


  printValue.Clear;

  printValue.Add('orgname', nvedtorgname.Text);//��ǰ����
  printValue.Add('toperator', nvedtsellby.Text);//����Ա
  printValue.Add('upmoneydate', FormatDateTime('yyyy-MM-dd', dtpupmoneydate.DateTime));//Ӫ������

  printValue.Add('acceptpieces',nvedtsendpacks.Text);//�������
  printValue.Add('acceptmoney', nvedtsendpackamount.Text);//������
  printValue.Add('pkuppieces', nvedtpickups.Text);//�������
  printValue.Add('pkupmoney', nvedtpickupamount.Text);//������

  printValue.Add('totalfeemoney', nvedtmoneypayable.Text);// Ӧ�ɿ�
  printValue.Add('actupmoney', nvedtactupmoney.Text);// ʵ�ɿ�
  printValue.Add('receivername', SysInfo.LoginUserInfo.UserName);// �տ���
  printValue.Add('receipttime', FormatDateTime('yyyy-MM-dd', dtpreceipttime.DateTime));//�տ�ʱ��

  billPrint.SingleValue := printValue;
  billPrint.Print;
end;

end.
