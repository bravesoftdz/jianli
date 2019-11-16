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
  upmoneydate:TDateTime;//	date	n			营收日期
  sellby:Integer;//	number(10)	n			办理员
  sendpacks:Integer;//	number(6)	y			受理件数
  sendpackamount:Double;//	number(10,2)	n			受理营收
  pickups:Integer;//	number(6)	y			提领件数
  pickupamount:Double;//	number(10,2)	y			提领营收
  goods:Integer;//	number(6)	y			寄存件数
  goodsamount:Double;//	number(10,2)	y			寄存营收
  moneypayable:Double;//	number(10,2)	y			应缴款
  actupmoney:Double;//	number(10,2)	y			实缴款
  receiver:Integer;//	number(10)	y			收款人id
  receipttime:TDateTime;//	date	y			收款时间
  receiptip:string;//	varchar2(20)	y			收款ip
  remak:string;//	varchar2(50)	y			备注
  orgid:Integer;//	number(10)	y			收站机构id
  createtime:TDateTime;//	date	n	sysdate
  createby:Integer;//	number(10)	n
  updatetime:TDateTime;//	date	n	sysdate
  updateby:Integer;//	number(10)	n

  //多个日期一起缴款
  as_sendpacks,as_pickups,as_depositpieces,as_recaptionspieces,
  as_sendpackamount,as_pickupamount,as_goodsamount,as_moneypayable,
  as_upmoneydate,as_lastlost:string;

  packdatafrom:integer; //数据来源

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
      SysDialogs.ShowMessage('受理件数数值超出范围(0~999999)!');
      nvedtsendpacks.Text :='999999';
      nvedtsendpacks.SetFocus;
      exit;
    end;
  end;

  if (Trim(nvedtsendpackamount.Text) <> '') then
  begin
    if StrToFloat(nvedtsendpackamount.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('受理金额数值超出范围(0~99999999.99)!');
      nvedtsendpackamount.Text :='99999999.99';
      nvedtsendpackamount.SetFocus;
      exit;
    end;
  end;


  if (Trim(nvedtpickups.Text) <> '') then
  begin
    if StrToFloat(nvedtpickups.Text)>=1000000 then
    begin
      SysDialogs.ShowMessage('提领件数数值超出范围(0~999999)!');
      nvedtpickups.Text :='999999';
      nvedtpickups.SetFocus;
      exit;
    end;
  end;

  if (Trim(nvedtpickupamount.Text) <> '') then
  begin
    if StrToFloat(nvedtpickupamount.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('提领金额数值超出范围(0~99999999.99)!');
      nvedtpickupamount.Text :='99999999.99';
      nvedtpickupamount.SetFocus;
      exit;
    end;
  end;

  if (Trim(nvedtmoneypayable.Text) <> '') then
  begin
    if StrToFloat(nvedtmoneypayable.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('应缴款金额数值超出范围(0~99999999.99)!');
      nvedtmoneypayable.SetFocus;
      nvedtmoneypayable.Text :='99999999.99';
      exit;
    end;
  end;

  if trim(nvedtactupmoney.Text)='' then
  begin
    SysDialogs.ShowMessage('实缴款不能为空');
    nvedtactupmoney.Text :=nvedtmoneypayable.Text;
    nvedtactupmoney.SetFocus;
    exit;
  end;

  if (Trim(nvedtactupmoney.Text) <> '') then
  begin
    if StrToFloat(nvedtmoneypayable.Text)>=100000000 then
    begin
      SysDialogs.ShowMessage('实缴款金额数值超出范围(0~99999999.99)!');
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
      ('yyyy-mm-dd', dtpupmoneydate.DateTime);//营收日期
    Params.ParamByName('packtturnover.sellby').Value := IntToStr(nvedtsellby.Id);//	办理员
    Params.ParamByName('packtturnover.sendpacks').Value := nvedtsendpacks.Text;//受理件数
    Params.ParamByName('packtturnover.sendpackamount').Value := nvedtsendpackamount.Text;//受理金额
    Params.ParamByName('packtturnover.pickups').Value := nvedtpickups.Text;//提领件数
    Params.ParamByName('packtturnover.pickupamount').Value := nvedtpickupamount.Text;//提领金额

    Params.ParamByName('packtturnover.moneypayable').Value := nvedtmoneypayable.Text;//应缴款
    Params.ParamByName('packtturnover.actupmoney').Value := trim(nvedtactupmoney.Text);//实缴款

    Params.ParamByName('packtturnover.lost').Value := trim(nvedtlost.Text);//本期溢欠款
    Params.ParamByName('packtturnover.receiver').Value := IntToStr(SysInfo.LoginUserInfo.UserID);//收款人
    Params.ParamByName('packtturnover.receipttime').Value := FormatDateTime('yyyy-mm-dd', dtpreceipttime.DateTime);//收款时间
    Params.ParamByName('packtturnover.receiptip').Value := '';//收款ip
    Params.ParamByName('packtturnover.remak').Value := trim(memremarks.Text);//备注
    Params.ParamValues['packtturnover.orgid']:= IntToStr(SysInfo.LoginUserInfo.OrgID);//收站机构

    Params.ParamValues['pactturnoverdetailid']:= pactturnoverdetailid;// 行包缴款明细表ID

    Params.ParamValues['packtturnover.packstrike']:= nvedtpackstrike.Text;//行包冲账

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
        result := '修改'
      else
        result := '添加';
      log := result +VarToStr(Params.ParamValues['packtturnoverid'])+ '行包缴款：当前机构='+SysInfo.LoginUserInfo.OrgName+
      ',营收日期='+FormatDateTime('yyyy-mm-dd', dtpupmoneydate.DateTime)+
       ',办理员='+nvedtsellby.Text+
      ',受理件数='+nvedtsendpacks.Text+',受理金额='+nvedtsendpackamount.Text+
      ',提领件数='+nvedtpickups.Text+',提领金额='+nvedtsendpackamount.Text+
      ',应缴款='+nvedtmoneypayable.Text+',实缴款='+nvedtactupmoney.Text+
       ',本期溢欠款='+nvedtlost.Text+
       ',收款人='+SysInfo.LoginUserInfo.UserName+',备注='+memremarks.Text;
      SysLog.WriteLog('行包管理->行包缴款',result,log);

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
   printValue: TDictionary<String, String>; // 输出单变量
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('行包缴款单',
      '行包缴款单'));


  printValue.Clear;

  printValue.Add('orgname', nvedtorgname.Text);//当前机构
  printValue.Add('toperator', nvedtsellby.Text);//办理员
  printValue.Add('upmoneydate', FormatDateTime('yyyy-MM-dd', dtpupmoneydate.DateTime));//营收日期

  printValue.Add('acceptpieces',nvedtsendpacks.Text);//受理件数
  printValue.Add('acceptmoney', nvedtsendpackamount.Text);//受理金额
  printValue.Add('pkuppieces', nvedtpickups.Text);//提领件数
  printValue.Add('pkupmoney', nvedtpickupamount.Text);//提领金额

  printValue.Add('totalfeemoney', nvedtmoneypayable.Text);// 应缴款
  printValue.Add('actupmoney', nvedtactupmoney.Text);// 实缴款
  printValue.Add('receivername', SysInfo.LoginUserInfo.UserName);// 收款人
  printValue.Add('receipttime', FormatDateTime('yyyy-MM-dd', dtpreceipttime.DateTime));//收款时间

  billPrint.SingleValue := printValue;
  billPrint.Print;
end;

end.
