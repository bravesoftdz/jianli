unit UFrmVipturnoverEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet, NovaPrint,Generics.Collections;

type
  TFrmVipturnoverEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    edtmoneypayable: TNovaEdit;
    edtsellnum: TNovaEdit;
    edtreturnnum: TNovaEdit;
    edtreturnmoney: TNovaEdit;
    edtcardnum: TNovaEdit;
    edtcardcose: TNovaEdit;
    edtsellmoney: TNovaEdit;
    edtreturnhandcharge: TNovaEdit;
    grp3: TGroupBox;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl21: TLabel;
    edtpayable: TNovaEdit;
    edtlastlost: TNovaEdit;
    edtmoney: TNovaEdit;
    edtlost: TNovaEdit;
    mmo1: TMemo;
    lbl6: TLabel;
    lbl8: TLabel;
    lbl10: TLabel;
    jcdsVipcard: TjsonClientDataSet;
    dsSource: TDataSource;
    jcdsSaveVipturnover: TjsonClientDataSet;
    btnPrint: TBitBtn;
    jcdsResult1: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure edtmoneyChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure printVipcardturnover(turnoverid: Int64);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    turnoverPrint : TNovaprint;
    printValue: TDictionary<String, String>;
  public
    { Public declarations }
    moneydate, parameter, templtename : string;
    id, rechargenum,returnnum,issuenum, userid : Int64;
    rechargemoney, returnmoney, returnhandcharge, issuemoney,moneypayable : Currency;
    startdate, enddate : TDateTime;
  end;

var
  FrmVipturnoverEdit: TFrmVipturnoverEdit;

implementation

uses Services, PubFn, StrUtils;
{$R *.dfm}

procedure TFrmVipturnoverEdit.bbtnSaveClick(Sender: TObject);
var sResult : string;
    nResult : Int64;
begin
  inherited;
  if Trim(edtmoney.Text) = '' then
  begin
    SysDialogs.ShowMessage('������ʵ�ɿ��');
    edtmoney.SetFocus;
    Exit;
  end;
  with jcdsSaveVipturnover do
  begin
    Params.ParamValues['vipcardturnover.cardcost'] := edtcardcose.Text;
    Params.ParamValues['vipcardturnover.issuenum'] := edtcardnum.Text;
    Params.ParamValues['vipcardturnover.money'] := edtmoney.Text;
    Params.ParamValues['vipcardturnover.rechargecount'] := edtsellnum.Text;
    Params.ParamValues['vipcardturnover.rechargemoney'] := edtsellmoney.Text;
    Params.ParamValues['vipcardturnover.returncardcost'] := edtreturnhandcharge.Text;
    Params.ParamValues['vipcardturnover.returnmoney'] := edtreturnmoney.Text;
    Params.ParamValues['vipcardturnover.returnnum'] := edtreturnnum.Text;
    Params.ParamValues['vipcardturnover.sellerid'] := userid;
    Params.ParamValues['vipcardturnover.moneypayable'] := edtmoneypayable.Text;
    Params.ParamValues['vipcardturnover.lastlost'] := edtlastlost.Text;
    Params.ParamValues['vipcardturnover.lost'] := edtlost.Text;
    Params.ParamValues['vipcardturnover.remark'] := mmo1.Text;
    Params.ParamValues['moneydate'] := moneydate;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtmoney.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;

        printVipcardturnover(id);
        ModalResult := mrok;
//        btnPrint.Enabled := True;
//        bbtnSave.Enabled := False;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('VIP�ɿ�ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVipturnoverEdit.btnPrintClick(Sender: TObject);
begin
  inherited;
//  printVipcardturnover(id);
//  ModalResult := mrok;
end;

procedure TFrmVipturnoverEdit.edtmoneyChange(Sender: TObject);
var value, money : Double;
   s, temp :string;
   ef:extended;
begin
  inherited;
  temp := LeftStr(edtmoney.Text, 1);
  if Trim(temp) = '-' then
  begin
    temp := Copy(edtmoney.Text, 2, Length(edtmoney.Text) - 1);
    if Length(temp) = 0 then
    begin
      temp := '0';
    end else
    begin
      money := StrToFloat(temp);
    end;
    value := StrToFloat(edtlastlost.Text) - StrToFloat(edtpayable.Text) - money;
  end else
  begin
    money := StrToFloat(edtmoney.Text);
    value := StrToFloat(edtlastlost.Text) - StrToFloat(edtpayable.Text) + money;
  end;
  s:='#.'+ StringOfChar('0', 2);
  ef:=StrToFloat(FloatToStr(value));//��ֹ������������
  value:=StrToFloat(FormatFloat(s,ef));
  edtlost.Text := FloatToStr(value);
//  mmo1.Text := 'Ӧ�ɿ�='+edtpayable.Text + ' ,ʵ�ɿ�='+edtmoney.Text +
//  ',������Ƿ��='+edtlastlost.Text + ',������Ƿ��='+edtlost.Text;
end;

procedure TFrmVipturnoverEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFrmVipturnoverEdit.FormShow(Sender: TObject);
begin
  inherited;
  parameter := getParametervalue('4009', SysInfo.LoginUserInfo.OrgID);
  with jcdsVipcard do
  begin
    Active := False;
      Params.ParamValues['userid'] := userid;
    Active := True;
    if not dsSource.DataSet.Active then
      exit;
    if dsSource.DataSet.RecordCount < 1 then
    begin
      edtlastlost.Text := IntToStr(0);
    end else
    begin
      edtlastlost.Text := jcdsVipcard.FieldByName('lost').Text;
    end;
    if parameter = '1' then
    begin
      edtmoney.Text := edtpayable.Text;
      edtmoney.Enabled:=false;
      mmo1.Text := 'Ӧ�ɿ�='+edtpayable.Text + ' ,ʵ�ɿ�='+edtmoney.Text;
    end
    else
    begin
      edtmoney.Enabled:=true;
    end;
  end;
end;

procedure TFrmVipturnoverEdit.printVipcardturnover(turnoverid: Int64);
begin
  if id <> 0 then
  begin
    turnoverid := id;
  end;
  templtename := TNovaPrint.GetTicketModelName('VIP�ɿ�', 'VIP�ɿ�');
  if not Assigned(turnoverPrint) then
    turnoverPrint := TNovaPrint.Create(self, templtename);
   // notprintValue:=getNotprintValue(SysInfo.LoginUserInfo.OrgID,vehicleid,templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  with jcdsResult1 do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_v!id'] := turnoverid;
    Active := True;
    printValue.Add('sellname', FieldByName('sellname').AsString);
    printValue.Add('createname', FieldByName('createname').AsString);
    printValue.Add('turnoverdate', FieldByName('turnoverdate').AsString);
    printValue.Add('money', FieldByName('money').AsString);
    printValue.Add('lastlost', FieldByName('lastlost').AsString);
    printValue.Add('lost', FieldByName('lost').AsString);
    printValue.Add('issuenum', FieldByName('issuenum').AsString);
    printValue.Add('moneypayable', FieldByName('moneypayable').AsString);
    printValue.Add('rechargemoney', FieldByName('rechargemoney').AsString);
    printValue.Add('returnnum', FieldByName('returnnum').AsString);
    printValue.Add('returnmoney', FieldByName('returnmoney').AsString);
    printValue.Add('cardcost', FieldByName('cardcost').AsString);
    printValue.Add('remark', FieldByName('remark').AsString);
    printValue.Add('rechargecount', FieldByName('rechargecount').AsString);
    printValue.Add('returncardcost', FieldByName('returncardcost').AsString);
//    printValue.Add('createtime', FieldByName('createtime').AsString);
  end;
  turnoverPrint.SingleValue := printValue;
  turnoverPrint.Print;
end;

end.
