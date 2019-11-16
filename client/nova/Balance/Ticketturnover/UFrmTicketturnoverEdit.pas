unit UFrmTicketturnoverEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet, NovaHelp, ImgList;

type
  TFrmTicketturnoverEdit = class(TSimpleEditForm)
    jcdsResultSaveTicketturnover: TjsonClientDataSet;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lblnoncashmoney: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl12: TLabel;
    lbl15: TLabel;
    edtmoneypayable: TNovaEdit;
    edtsellnum: TNovaEdit;
    edtsellmoney: TNovaEdit;
    edtreturnnum: TNovaEdit;
    edtreturnmoney: TNovaEdit;
    edtreturnhandcharge: TNovaEdit;
    edtcancelnum: TNovaEdit;
    edtcancelmoney: TNovaEdit;
    edtnoncashnum: TNovaEdit;
    edtnoncashmoney: TNovaEdit;
    edteticketnum: TNovaEdit;
    edtnonvouchermoneypayable: TNovaEdit;
    edtservicefee: TNovaEdit;
    edtbookservicefee: TNovaEdit;
    grp2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtinsuremoneypayable: TNovaEdit;
    edtinsuresellnum: TNovaEdit;
    edtinsuresellmoney: TNovaEdit;
    edtinsurereturnnum: TNovaEdit;
    edtinsurereturnmoney: TNovaEdit;
    edtinsurereturnhandcharge: TNovaEdit;
    edtinsurecancelnum: TNovaEdit;
    edtinsurecancelmoney: TNovaEdit;
    edtinsureeticketnum: TNovaEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtinsurenoncashmoney: TNovaEdit;
    edtinsurenonvouchermoneypayable: TNovaEdit;
    lbl16: TLabel;
    edtinsurenoncashnum: TNovaEdit;
    grp3: TGroupBox;
    dsSource: TDataSource;
    jcdsResultTicket: TjsonClientDataSet;
    lbl2: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    edtpayable: TNovaEdit;
    edtmoney: TNovaEdit;
    edtlost: TNovaEdit;
    mmo1: TMemo;
    lbl20: TLabel;
    edtchangsservicefee: TNovaEdit;
    lbl21: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtsellreturntripnum: TNovaEdit;
    edtreturnprintnum: TNovaEdit;
    edtbilldamagednum: TNovaEdit;
    lbl22: TLabel;
    nvedtallnonvouchermoneypayable: TNovaEdit;
    nvedtallvouchermoneypayable: TNovaEdit;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    Label15: TLabel;
    chkautoprint: TCheckBox;
    Label16: TLabel;
    edtticketstrike: TNovaEdit;
    Label17: TLabel;
    edtinsurstrike: TNovaEdit;
    Label18: TLabel;
    edtticketmoneypayable: TNovaEdit;
    Label19: TLabel;
    nedtinsuremoneypayable: TNovaEdit;
    Label20: TLabel;
    edtbalance: TNovaEdit;
    Label21: TLabel;
    edtlastlost: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtmoneyChange(Sender: TObject);
    procedure refreshStrike;
    procedure edtticketstrikeChange(Sender: TObject);
    procedure edtinsurstrikeChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    sign : Boolean;
    id, createby, createtime, ticketdetailid, insuredetail,
    returnticketno, cancelticketno, damagedticketno,
    returninsureno, cancelinsureno, damagedinsureno, parameter, isautoprint : string;
    seller, sellnum, returnnum, cancelnum, noncashnum, eticketnum, insurenoncashnum,
    insuresellnum, insurereturnnum, insurecancelnum, insureeticketnum,tchangenum: LongWord;

    moneypayable, sellmoney, cancelmoney, noncashmoney, returnmoney, servicefee,
    returnhandcharge, nonvouchermoneypayable, bookservicefee, changeservicefee,
    insuremoneypayable, insuresellmoney, insurecancelmoney, insurenoncashmoney,
    insurereturnmoney, insurereturnhandcharge, insurenonvouchermoneypayable,lastlost : Currency;

    billnouse,moneydate:String //票证消耗段
  end;

var
  FrmTicketturnoverEdit: TFrmTicketturnoverEdit;

implementation

uses Services, UFrmTicketturnoverReport, StrUtils, PubFn;
{$R *.dfm}

procedure TFrmTicketturnoverEdit.bbtnSaveClick(Sender: TObject);
var nResult, ticketid : LongWord;
    sResult: string;
begin
  inherited;

    if edtinsurstrike.Text='' then
  begin
     edtinsurstrike.Text:='0';
  end;
    if edtticketstrike.Text='' then
  begin
     edtticketstrike.Text:='0';
  end;
  if edtbalance.Text='' then
  begin
     edtbalance.Text:='0';
  end;
  if Trim(edtmoney.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入实缴款金额。');
    edtmoney.SetFocus;
    Exit;
  end;
  bbtnSave.Enabled:=True;
  with jcdsResultSaveTicketturnover do
  begin
    Close;
    if Trim(id) = '' then
      Params.ParamValues['ticketturnover.id'] := null
    else
      Params.ParamValues['ticketturnover.id'] := id;
    Params.ParamValues['ticketturnover.moneypayable'] := edtpayable.Text;//车票缴款+保险缴款
    Params.ParamValues['ticketturnover.sellnum'] := edtsellnum.Text;
    Params.ParamValues['ticketturnover.sellmoney'] := edtsellmoney.Text;
    Params.ParamValues['ticketturnover.returnnum'] := edtreturnnum.Text;
    Params.ParamValues['ticketturnover.returnmoney'] := edtreturnmoney.Text;
    Params.ParamValues['ticketturnover.returnhandcharge'] := edtreturnhandcharge.Text;
    Params.ParamValues['ticketturnover.cancelnum'] := edtcancelnum.Text;
    Params.ParamValues['ticketturnover.cancelmoney'] := edtcancelmoney.Text;
    Params.ParamValues['ticketturnover.eticketnum'] := edteticketnum.Text;
    Params.ParamValues['ticketturnover.bookservicefee'] := edtbookservicefee.Text;
    Params.ParamValues['ticketturnover.servicefee'] := edtservicefee.Text;
    Params.ParamValues['ticketturnover.nonvouchermoneypayable'] := edtnonvouchermoneypayable.Text;
    Params.ParamValues['ticketturnover.noncashnum'] := edtnoncashnum.Text;
    Params.ParamValues['ticketturnover.noncashmoney'] := edtnoncashmoney.Text;
    Params.ParamValues['ticketturnover.changeservicefee'] := edtchangsservicefee.Text;
    Params.ParamValues['ticketturnover.sellreturntripnum'] := edtsellreturntripnum.Text;
    Params.ParamValues['ticketturnover.returnprintnum'] := edtreturnprintnum.Text;
    Params.ParamValues['ticketturnover.billdamagednum'] := edtbilldamagednum.Text;
    Params.ParamValues['ticketturnover.ticketstrike'] := edtticketstrike.Text;
    Params.ParamValues['ticketturnover.insurstrike'] := edtinsurstrike.Text;
    Params.ParamValues['ticketturnover.ticketmoneypayable'] := edtticketmoneypayable.Text;
    Params.ParamValues['ticketturnover.insuremoneypayable'] := nedtinsuremoneypayable.Text;
    Params.ParamValues['ticketturnover.ticketmoney'] := CurrToStr(StrToCurrDef(edtmoney.Text,0) - StrToCurrDef(nedtinsuremoneypayable.Text,0));
    Params.ParamValues['ticketturnover.insuremoney'] := nedtinsuremoneypayable.Text;
    Params.ParamValues['ticketturnover.balance'] := edtbalance.Text;
    if Trim(mmo1.Text) = '' then
      Params.ParamValues['ticketturnover.remarks'] := null
    else
      Params.ParamValues['ticketturnover.remarks'] := mmo1.Text;
    Params.ParamValues['ticketdetail'] := ticketdetailid;

    if not grp2.Visible then
    begin
      Params.ParamValues['ticketturnover.insuresellnum'] := 0;
      Params.ParamValues['ticketturnover.insuresellmoney'] := 0;
      Params.ParamValues['ticketturnover.insurereturnnum'] := 0;
      Params.ParamValues['ticketturnover.insurereturnmoney'] := 0;
      Params.ParamValues['ticketturnover.insurereturnhandcharge'] := 0;
      Params.ParamValues['ticketturnover.insurecancelnum'] := 0;
      Params.ParamValues['ticketturnover.insurecancelmoney'] := 0;
      Params.ParamValues['ticketturnover.insureeticketnum'] := 0;
      Params.ParamValues['ticketturnover.insurechargenum'] := 0;
      Params.ParamValues['ticketturnover.insurechargemoney'] := 0;
      Params.ParamValues['ticketturnover.insurenonvouchermoneypayable'] := 0;
      Params.ParamValues['insuredetail'] := '';
    end
    else
    begin
      Params.ParamValues['ticketturnover.insuresellnum'] := edtinsuresellnum.Text;
      Params.ParamValues['ticketturnover.insuresellmoney'] := edtinsuresellmoney.Text;
      Params.ParamValues['ticketturnover.insurereturnnum'] := edtinsurereturnnum.Text;
      Params.ParamValues['ticketturnover.insurereturnmoney'] := edtinsurereturnmoney.Text;
      Params.ParamValues['ticketturnover.insurereturnhandcharge'] := edtinsurereturnhandcharge.Text;
      Params.ParamValues['ticketturnover.insurecancelnum'] := edtinsurecancelnum.Text;
      Params.ParamValues['ticketturnover.insurecancelmoney'] := edtinsurecancelmoney.Text;
      Params.ParamValues['ticketturnover.insureeticketnum'] := edtinsureeticketnum.Text;
      Params.ParamValues['ticketturnover.insurechargenum'] := edtinsurenoncashnum.Text;
      Params.ParamValues['ticketturnover.insurechargemoney'] := edtinsurenoncashmoney.Text;
      Params.ParamValues['ticketturnover.insurenonvouchermoneypayable'] := edtinsurenonvouchermoneypayable.Text;
      Params.ParamValues['insuredetail'] := insuredetail;
    end;

    if Trim(createby) = '' then
      Params.ParamValues['ticketturnover.createby'] := null
    else
      Params.ParamValues['ticketturnover.createby'] := createby;
    if Trim(createtime) = '' then
      Params.ParamValues['ticketturnover.createtime'] := null
    else
      Params.ParamValues['ticketturnover.createtime'] := createtime;
    Params.ParamValues['ticketturnover.seller'] := seller;
    //Params.ParamValues['ticketturnover.lastlost'] := edtlastlost.Text;
        Params.ParamValues['ticketturnover.lastlost'] := '0';
    Params.ParamValues['ticketturnover.lost'] := FloatToStr(StrToFloat(edtlost.Text)*-1);
    Params.ParamValues['ticketturnover.money'] := edtmoney.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <> 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        FrmTicketturnoverEdit.Close;
      end else
      if (nResult = 1) then
      begin
      ticketid := Params.ParamByName('ticketturnoverid').Value;
        with FrmTicketturnoverreport do
        begin
          FrmTicketturnoverreport := TFrmTicketturnoverreport.Create(Self);
          ticketturnoverid := ticketid ;
          returntno := returnticketno;
          canceltno := cancelticketno;
          damagedtno := damagedticketno;
          returnino := returninsureno;
          cancelino := cancelinsureno;
          damagedino := damagedinsureno;
          billnouse := self.billnouse;
          moneydate := self.moneydate;
          returnmoney := StrToCurrdef(edtinsurereturnmoney.Text,0);
          returnhandcharge := StrToCurrdef(edtinsurereturnhandcharge.Text,0);
          changenum := tchangenum;
//          with jcdsResultTicketturnover do
//          begin
//            Active := False;
//            Params.ParamValues['returnticketno'] := returntno;
//            Params.ParamValues['cancelticketno'] := canceltno;
//            Params.ParamValues['damagedticketno'] := damagedtno;
//            Params.ParamValues['returninsureno'] := returnino;
//            Params.ParamValues['cancelinsureno'] := cancelino;
//            Params.ParamValues['damagedinsureno'] := damagedino;
//            Params.ParamValues['ticketturnoverid'] := ticketturnoverid;
//            Active := True;
//          end;
//          frxdbdtst1.DataSet := jcdsResultTicketturnover;
          if chkautoprint.Checked = true then
          begin
            ShowReport;
          end;
//          ShowModal;
        end;
        log := '营收缴款：缴款人='+IntToStr(seller)+',应缴款='+
        edtpayable.Text+',上期溢欠款='+'0.00'+',实缴款='+edtmoney.Text+
        ',本期溢欠款='+edtlost.Text+'。车票票款、应缴款='+
        edtmoneypayable.Text+',所有售票数='+edtsellnum.Text+',所有售票款='+
        edtsellmoney.Text+',退票数'+edtreturnnum.Text+',退票款='+
        edtreturnmoney.Text+',退票手续费='+edtreturnhandcharge.Text+
        ',废票数='+edtcancelnum.Text+',废票款='+edtcancelmoney.Text+',电子换票张数='+
        edteticketnum.Text+',订票服务费='+edtbookservicefee.Text+',补票服务费='+
        edtservicefee.Text+',改签服务费='+edtchangsservicefee.Text+'';
        SysLog.WriteLog('结算管理->营收缴款','营收缴款',log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('缴款失败：' + E.Message);
      end;
    end;
  end;
  bbtnSave.Enabled:=True;
end;

procedure TFrmTicketturnoverEdit.edtinsurstrikeChange(Sender: TObject);
begin
  inherited;
  nedtinsuremoneypayable.Text:= CurrToStr(StrToCurrDef(edtinsuremoneypayable.Text,0) - StrToCurrDef(edtinsurstrike.Text,0));
  refreshStrike;
  edtmoneyChange(Sender);
end;

procedure TFrmTicketturnoverEdit.edtmoneyChange(Sender: TObject);
var value, money : Currency;
   s:string;
begin
  inherited;
  money := StrToCurrdef(edtmoney.Text,0);
  value :=  money  + StrToCurrDef(edtnonvouchermoneypayable.Text,0) + StrToCurrdef(edtinsurenonvouchermoneypayable.Text,0)- StrToCurr(edtpayable.Text);
  s:='#.'+ StringOfChar('0', 2);
  value:=StrToCurr(FormatFloat(s,value));
  edtlost.Text := currToStr(value);
end;

procedure TFrmTicketturnoverEdit.edtticketstrikeChange(Sender: TObject);
begin
  inherited;
  edtticketmoneypayable.Text:= CurrToStr(StrToCurrDef(edtmoneypayable.Text,0) + StrToCurrDef(edtlastlost.Text,0) - StrToCurrDef(edtticketstrike.Text,0));
  refreshStrike;
  edtmoneyChange(Sender);
end;

procedure TFrmTicketturnoverEdit.refreshStrike();
begin
  inherited;
    edtpayable.Text := CurrToStr(StrToCurrDef(edtmoneypayable.Text,0) + StrToCurrDef(edtlastlost.Text,0) + StrToCurrDef(edtinsuremoneypayable.Text,0)-StrToCurrDef(edtticketstrike.Text,0)-StrToCurrDef(edtinsurstrike.Text,0));
     nvedtallvouchermoneypayable.Text := currtostr(StrToCurrDef(edtpayable.Text,0) - StrToCurrDef(nvedtallnonvouchermoneypayable.Text, 0));
    parameter := getParametervalue('4003', SysInfo.LoginUserInfo.OrgID);
     if parameter = '1' then
  begin
    edtmoney.Text := CurrToStr(StrToCurr(edtpayable.Text) - StrToCurrDef(edtnonvouchermoneypayable.Text,0) - StrToCurrdef(edtinsurenonvouchermoneypayable.Text,0));
    edtmoney.Enabled:=false;
  end
  else
  begin
    edtmoney.Enabled:=true;
  end;

end;

procedure TFrmTicketturnoverEdit.FormShow(Sender: TObject);
begin
  inherited;
  parameter := getParametervalue('4003', SysInfo.LoginUserInfo.OrgID);
  isautoprint := getParametervalue('4010', SysInfo.LoginUserInfo.OrgID);
  if isautoprint = '1' then
    chkautoprint.Checked := True
  else
    chkautoprint.Checked := False;
  if not grp2.Visible then
  begin
    self.Height:=self.Height-grp2.Height;
  end;
  with jcdsResultTicket do
  begin
    Active := False;
      Params.ParamValues['seller'] := seller;
    Active := True;
  end;
  if not dsSource.DataSet.Active then
    exit;
  //if dsSource.DataSet.RecordCount < 1 then
  //begin
  //  edtlastlost.Text := IntToStr(0);
  //end else
  //begin
  //  edtlastlost.Text := jcdsResultTicket.FieldByName('lost').Text;
  //end;
  if parameter = '1' then
  begin
    edtmoney.Text := CurrToStr(StrToCurr(edtpayable.Text) - StrToCurrDef(edtnonvouchermoneypayable.Text,0) - StrToCurrdef(edtinsurenonvouchermoneypayable.Text,0));
    edtmoney.Enabled:=false;
  end
  else
  begin
    edtmoney.Enabled:=true;
  end;
end;

end.


