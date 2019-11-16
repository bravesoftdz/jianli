unit UFrmFullCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, UICcardRW, DB, DBClient, jsonClientDataSet, UFrmViprecharge,
  NovaPrint;

type
  TFrmFullCard = class(TSimpleEditForm,Ivipcardfound)
    lbl4: TLabel;
    lbl2: TLabel;
    edtbalancemoney: TNovaEdit;
    edtmoney: TNovaEdit;
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mmoremark: TMemo;
    jcdsstatus1: TjsonClientDataSet;
    edttypename: TNovaEdit;
    jcdsSave: TjsonClientDataSet;
    jcdsrechargepromotion: TjsonClientDataSet;
    btnquery: TButton;
    lbl3: TLabel;
    edtamount: TNovaEdit;
    nvhlpcardno: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtmoneyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnqueryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FBillPrint:TNovaPrint;
    function initBillPrinter: boolean;
    function printbill: boolean;
    procedure vipcardfound(vipCard:TVipCard);
  public
    { Public declarations }
    activityid, cardResult : Integer;
    vipBaseCard : TVipCard;
    cardno : string;
  end;

var
  FrmFullCard: TFrmFullCard;

implementation

uses Services, PubFn, FunctionItemIntf;
{$R *.dfm}

procedure TFrmFullCard.bbtnSaveClick(Sender: TObject);
var nResult : Int64;
    sResult,log : string;
    _vipBaseCard : TVipCard;
begin
  inherited;
  with jcdsSave do
  begin
    params.ParamValues['cardno'] := nvhlpcardno.Text;
    Params.ParamValues['money'] := edtmoney.Text;
    Params.ParamValues['amount'] := edtamount.Text;
    Params.ParamValues['balancemoney'] := edtbalancemoney.Text;
    Params.ParamValues['activityid'] := activityid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpcardno.SetFocus;
      end
      else
      begin
        _vipBaseCard := vipBaseCard;
        vipBaseCard.incrementmoney(StrToCurr(edtmoney.Text));
        cardResult := _vipBaseCard.writeCard;
        while cardResult <> 0 do
        begin
          SysDialogs.Warning(_vipBaseCard.getErrorInfo(cardResult)+'。请放好VIP卡，按确定重新写卡。');
          //ShowMessage('警告','写卡失败：'+_vipBaseCard.getErrorInfo(cardResult)+'。请放好VIP卡，按确定重新写卡。');
          cardResult:=_vipBaseCard.writeCard;
        end;
        printbill;
        log := '顾客：'+edttypename.Text+',卡号：'+nvhlpcardno.Text+',剩余金额：'
        +edtbalancemoney.Text+',积分：'+edtamount.Text+'。充值金额：'+edtmoney.Text
        +',优惠活动：'+mmoremark.Text;
        SysLog.WriteLog('业务管理——>智能卡管理','智能卡充值',log);
        cardno := nvhlpcardno.Text;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('智能卡充值失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmFullCard.btnqueryClick(Sender: TObject);
var functionParm : TFunctionItemParameters;
begin
  inherited;
  if Trim(nvhlpcardno.Text) = '' then
  begin
    ShowMessage('请先刷卡！');
    Exit;
  end;

    functionParm := TFunctionItemParameters.Create;
    functionParm.CommaText := '1,'+nvhlpcardno.Text;
    SysFunctionMgr.exec(StringToGUID('{E39A6A01-67CD-4E5E-A46B-D033FCBF4239}'),functionParm);
end;

procedure TFrmFullCard.edtmoneyChange(Sender: TObject);
begin
  inherited;
  if Length(edtmoney.Text) > 1 then
  begin
    with jcdsrechargepromotion do
    begin
      Active := False;
        Params.ParamValues['cardno'] := nvhlpcardno.Text;
        Params.ParamValues['money'] := edtmoney.Text;
      Active := True;
    end;
    if jcdsrechargepromotion.FieldByName('name').AsString = '' then
      mmoremark.Text := '本次充值不享有优惠活动！'
    else
    begin
      mmoremark.Text := jcdsrechargepromotion.FieldByName('name').AsString;
      activityid := jcdsrechargepromotion.FieldByName('id').AsInteger;
    end;
  end else
  begin
    mmoremark.Text := '本次充值不享有优惠活动！';
  end;

end;

procedure TFrmFullCard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  try;
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmFullCard.FormCreate(Sender: TObject);
begin
  inherited;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
  if not initBillPrinter() then exit;
  try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
end;

procedure TFrmFullCard.FormDestroy(Sender: TObject);
begin
  inherited;
  try;
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

function TFrmFullCard.initBillPrinter: boolean;
begin
  inherited;
  result:=false;
  try
    FBillPrint:=TNovaPrint.create(Self,TNovaPrint.GetTicketModelName('VIP充值凭证','VIP充值凭证'));
    if FBillPrint<>nil then
      result:=true
    else
      SysDialogs.ShowError('初始化充值打印模板失败，未知错误');
  except on E: Exception do
    SysDialogs.ShowError('初始化充值打印模板失败：'+e.Message);
  end;
end;

function TFrmFullCard.printbill: boolean;
begin
  with FBillPrint.SingleValue do
  begin
    AddOrSetValue('customername', edttypename.Text);
    AddOrSetValue('vipcardno', nvhlpcardno.Text);
    AddOrSetValue('viplastmoney', edtbalancemoney.Text);
    AddOrSetValue('viplastamount',edtamount.Text);
    AddOrSetValue('rechargemoney', edtmoney.Text);
    AddOrSetValue('vipnewmoney', CurrToStr(strtocurr(edtbalancemoney.Text)+strtocurr(edtmoney.Text)));
    AddOrSetValue('remark', mmoremark.Text);
    FBillPrint.Print;
  end;
end;

procedure TFrmFullCard.vipcardfound(vipCard: TVipCard);
begin
  if Integer(vipCard.cardtype) <> 3 then
  begin
    SysDialogs.ShowMessage('该卡不是贵宾卡，不能进行充值！');
    Exit;
  end;
  nvhlpcardno.Text := vipCard.cardNo;
  edtbalancemoney.Text := CurrToStr(vipCard.money);
  edtamount.Text := CurrToStr(vipCard.amount);
  vipBaseCard := vipCard;
  with jcdsstatus1 do
  begin
    Active := False;
      Params.ParamValues['helpType'] := 'VipHelp';
      Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcardno.Text;
      Params.ParamValues['filter_EQS_v!status'] := 0;
    Active := True;
    if  jcdsstatus1.FieldByName('name').AsString = ''then
    begin
      SysDialogs.ShowMessage('该卡已不是正常状态，请核对后再来充值！');
      nvhlpcardno.Text := '';
      nvhlpcardno.SetFocus;
      Exit;
    end else
      edttypename.Text := jcdsstatus1.FieldByName('name').AsString;
  end;
end;
end.
