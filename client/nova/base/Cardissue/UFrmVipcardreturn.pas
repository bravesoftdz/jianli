unit UFrmVipcardreturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet, UICcardRW;

type
  TFrmVipcardreturn = class(TSimpleEditForm,Ivipcardfound)
    lbl4: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    Label1: TLabel;
    nvhlpcardno: TNovaHelp;
    edtmoney: TNovaEdit;
    edtamount: TNovaEdit;
    edttypename: TNovaEdit;
    jcdsstatus1: TjsonClientDataSet;
    Label2: TLabel;
    edtreturnmoney: TNovaEdit;
    Label3: TLabel;
    edtreturncardcose: TNovaEdit;
    lbl3: TLabel;
    mmoremark: TMemo;
    jcdsSave: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtreturnmoneyChange(Sender: TObject);
    procedure edtreturncardcoseChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure vipcardfound(vipCard:TVipCard);
  public
    { Public declarations }
    vipid, writcard : Integer;
    vipBaseCard : TVipCard;
    cardno : string;
  end;

var
  FrmVipcardreturn: TFrmVipcardreturn;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmVipcardreturn.bbtnSaveClick(Sender: TObject);
var sResult, log : string;
    nResult : Int64;
    _vipBaseCard : TVipCard;
begin
  inherited;
    if edttypename.Text ='' then
  begin
    ShowMessage('请刷卡！');
    Exit;
  end;
  if Trim(edtreturnmoney.Text) = '' then
  begin
    ShowMessage('请填写退还金额！');
    Exit;
  end;
  if Trim(edtreturncardcose.Text) = '' then
  begin
    ShowMessage('请填写退还工本费！');
    Exit;
  end;

  with jcdsSave do
  begin
    Params.ParamValues['vipreturn.remainmoney'] := edtreturnmoney.Text;
    Params.ParamValues['vipreturn.cardcost'] := edtreturncardcose.Text;
    Params.ParamValues['vipreturn.remarks'] := mmoremark.Text;
    Params.ParamValues['vipreturn.vipid'] := vipid;

    try
      Execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtreturnmoney.SetFocus;
      end
      else
      begin
        _vipBaseCard := vipBaseCard;
        _vipBaseCard.decrementmoney(_vipBaseCard.money);
        _vipBaseCard.decrementamount(_vipBaseCard.amount);
        writcard := _vipBaseCard.writeCard;
        while writcard <> 0 do
        begin
          SysDialogs.Warning(_vipBaseCard.getErrorInfo(writcard)+'。请放好VIP卡，按确定重新写卡。');
          writcard:=_vipBaseCard.writeCard;
        end;
        log := '顾客：'+edttypename.Text+',卡号：'+nvhlpcardno.Text+',剩余金额：'
        +edtmoney.Text+',积分：'+edtamount.Text+'。退还金额：'+edtreturnmoney.Text
        +',退还工本费：'+edtreturncardcose.Text;
        SysLog.WriteLog('业务管理——>智能卡管理','智能卡退卡',log);
        cardno := nvhlpcardno.Text;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('智能卡退卡失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVipcardreturn.edtreturncardcoseChange(Sender: TObject);
begin
  inherited;
  mmoremark.Text := '退还余额=' + edtreturnmoney.Text+',退工本费='+edtreturncardcose.Text;
end;

procedure TFrmVipcardreturn.edtreturnmoneyChange(Sender: TObject);
begin
  inherited;
  mmoremark.Text := '退还余额=' + edtreturnmoney.Text+',退工本费='+edtreturncardcose.Text;
end;

procedure TFrmVipcardreturn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  try;
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmVipcardreturn.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
    setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
    setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
    setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
    setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
    setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

procedure TFrmVipcardreturn.FormDestroy(Sender: TObject);
begin
  inherited;
  try;
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmVipcardreturn.vipcardfound(vipCard: TVipCard);
begin
  vipBaseCard := vipCard;
  nvhlpcardno.Text := vipCard.cardNo;
  edtmoney.Text := CurrToStr(vipCard.money);
  edtamount.Text := CurrToStr(vipCard.amount);
  edtreturnmoney.Text := CurrToStr(vipCard.money);
  with jcdsstatus1 do
  begin
    Active := False;
      Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcardno.Text;
      Params.ParamValues['filter_EQS_v!status'] := 0;
    Active := True;
    if jcdsstatus1.FieldByName('name').AsString <> '' then
    begin
      edttypename.Text := jcdsstatus1.FieldByName('name').AsString;
      edtreturncardcose.Text := jcdsstatus1.FieldByName('cardcost').AsString;
      vipid := jcdsstatus1.FieldByName('id').AsInteger;
      mmoremark.Text := '退还余额=' + edtreturnmoney.Text+',退工本费='+edtreturncardcose.Text;
    end else
    begin
      ShowMessage('该卡不是正常卡，不能退！');
      Exit;
    end;
  end;
end;

end.
