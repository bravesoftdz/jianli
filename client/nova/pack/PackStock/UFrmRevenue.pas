unit UFrmRevenue;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
NovaHComboBox, ImgList, ComCtrls,NovaPrint,Generics.Collections;

type
TFrmRevenue = class(TSimpleEditForm)
    jcdsrevenue: TjsonClientDataSet;
  Label2: TLabel;
  Label8: TLabel;
  Label22: TLabel;
  Label27: TLabel;
  Label51: TLabel;
  Label3: TLabel;
  Label15: TLabel;
  Label14: TLabel;
  nvedtacceptpieces: TNovaEdit;
  nvedtaccepttotalfee: TNovaEdit;
    nvedtdepositpieces: TNovaEdit;
    nvedtgoodstotalfee: TNovaEdit;
  nvedttotalfee: TNovaEdit;
    nvedtpkuptotalfee: TNovaEdit;
    nvedtpkuppieces: TNovaEdit;
  nvedtoperator: TNovaEdit;
  nvedtorgname: TNovaEdit;
  Label1: TLabel;
    jcdsrevenueaccepttotalfee: TFloatField;
    jcdsrevenuegoodstotalfee: TFloatField;
    jcdsrevenuepkuptotalfee: TFloatField;
    jcdsrevenueacceptpieces: TIntegerField;
    jcdsrevenuegoodspieces: TIntegerField;
    jcdsrevenuepkuppieces: TIntegerField;
    Label4: TLabel;
    nvedtrecaptionspieces: TNovaEdit;
    jcdsrevenuedepositpieces: TIntegerField;
    jcdsrevenuerecaptionspieces: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);

private
  { Private declarations }
  Foperationid: Integer;
  log:string;
  procedure PrintClink;
public
  { Public declarations }
packid:Integer;//	;//number(10)	n

property operationid: Integer read Foperationid;
end;

var
FrmRevenue: TFrmRevenue;

implementation
uses PubFn,DateUtils;
{$R *.dfm}

procedure TFrmRevenue.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  PrintClink;
end;

procedure TFrmRevenue.FormShow(Sender: TObject);
begin
  inherited;

  nvedtorgname.Id := Sysinfo.LoginUserInfo.OrgID;
  nvedtorgname.Text := Sysinfo.LoginUserInfo.OrgName;
  nvedtoperator.Text := Sysinfo.LoginUserInfo.UserName;

  with jcdsrevenue do
  begin
    Active :=false;

    Params.ParamValues['orgid'] := '('+IntToStr(Sysinfo.LoginUserInfo.OrgID)+')';
    Params.ParamValues['fromdate'] := FormatDateTime
      ('yyyy-mm-dd', Now());
    Params.ParamValues['enddate'] := FormatDateTime
      ('yyyy-mm-dd', Now()+1);


    Params.ParamValues['userid'] := IntToStr(Sysinfo.LoginUserInfo.UserID);


    Active :=true;
    while not eof do
    begin

      nvedtacceptpieces.Text :=FieldByName('acceptpieces').AsString;
      nvedtaccepttotalfee.Text := FieldByName('accepttotalfee').AsString;
      nvedtdepositpieces.Text :=FieldByName('depositpieces').AsString;
      nvedtrecaptionspieces.Text :=FieldByName('recaptionspieces').AsString;
      nvedtgoodstotalfee.Text := FieldByName('goodstotalfee').AsString;
      nvedtpkuppieces.Text :=FieldByName('pkuppieces').AsString;
      nvedtpkuptotalfee.Text := FieldByName('pkuptotalfee').AsString;

      nvedttotalfee.Text := FloatToStr(FieldByName('accepttotalfee').AsFloat+
                                  FieldByName('goodstotalfee').AsFloat+
                                  FieldByName('pkuptotalfee').AsFloat);

    Next;
    end;

//    if nvedtacceptpieces.Text='' then
//      nvedtacceptpieces.Text:='0';
//    if nvedtaccepttotalfee.Text='' then
//      nvedtaccepttotalfee.Text:='0';
//    if nvedtgoodspieces.Text='' then
//      nvedtgoodspieces.Text:='0';
//    if nvedtgoodstotalfee.Text='' then
//      nvedtgoodstotalfee.Text:='0';
//    if nvedtpkuppieces.Text='' then
//      nvedtpkuppieces.Text:='0';
//    if nvedtpkuptotalfee.Text='' then
//      nvedtpkuptotalfee.Text:='0';

  end;
end;

procedure TFrmRevenue.PrintClink();
var billPrint: TNovaPrint;
   printValue: TDictionary<String, String>; // 输出单变量
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('行包员营收单',
      '行包员营收单'));


  printValue.Clear;

  printValue.Add('orgname', nvedtorgname.Text);//当前机构
  printValue.Add('toperator', nvedtoperator.Text);//办理员
  printValue.Add('acceptpieces',nvedtacceptpieces.Text);//受理件数
  printValue.Add('acceptmoney', nvedtaccepttotalfee.Text);//受理金额
  printValue.Add('depositpieces', nvedtdepositpieces.Text);//小件寄存件数
  printValue.Add('recaptionspieces', nvedtrecaptionspieces.Text);//小件提取件数
  printValue.Add('goodsmoney', nvedtgoodstotalfee.Text);//寄存金额
  printValue.Add('pkuppieces', nvedtpkuppieces.Text);//提领件数
  printValue.Add('pkupmoney', nvedtpkuptotalfee.Text);//提领金额
  printValue.Add('totalfeemoney', nvedttotalfee.Text);// 合计金额
  printValue.Add('printdate', FormatDateTime('yyyy-MM-dd', Now));//打印时间



  billPrint.SingleValue := printValue;
  billPrint.Print;



end;

end.
