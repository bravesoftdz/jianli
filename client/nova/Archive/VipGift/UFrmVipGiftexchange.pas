unit UFrmVipGiftexchange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList,UFrmVipGiftExchangelog, UICcardRW, CardManage,
  NovaCheckedComboBox;

type
  TfrmVipGiftexchange = class(TSimpleEditForm, Ivipcardfound)
    jcdsSave: TjsonClientDataSet;
    lbl1: TLabel;
    lbl5: TLabel;
    mmoRemark: TMemo;
    lblNum: TLabel;
    lbl8: TLabel;
    edtNum: TNovaEdit;
    edtLeaveNum: TNovaEdit;
    lbl10: TLabel;
    lbl4: TLabel;
    lbl2: TLabel;
    edtVipgrade: TNovaEdit;
    lbl3: TLabel;
    edtVipAmount: TNovaEdit;
    jcdsVipgiftname: TjsonClientDataSet;
    jcdsFindcardInfo: TjsonClientDataSet;
    edtCoustomername: TNovaEdit;
    lbl6: TLabel;
    edtMoney: TNovaEdit;
    lbl7: TLabel;
    lblTakeamount: TLabel;
    nvhlpVipGiftname: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtNumChange(Sender: TObject);
    procedure vipcardfound(vipCard:TVipCard);
    procedure FormCreate(Sender: TObject);
    procedure nvhlpVipGiftnameChange(Sender: TObject);
    procedure nvhlpVipGiftnameIdChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject); private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    vipBaseCard : TVipCard;
   id,vipgiftid,vipid,afternum,coustemerid,leaveNum, leaveamount,
   gradeneedamount,vipamount:integer;
   vipgrade,operation,customname: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmVipGiftexchange: TfrmVipGiftexchange;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmVipGiftexchange.bbtnSaveClick(Sender: TObject);
 var  msg: String;
    _vipcard  : TVipCard;
  nResult,afterstoragequantity,
  chageamount,//消耗的积分
  cardresult: integer;
  sResult,log,optype: String;
begin
  inherited;
  if nvhlpVipGiftname.Text='' then
  begin
    SysDialogs.ShowMessage('请输入要兑换的礼物名称！');
    nvhlpVipGiftname.SetFocus;
    Exit;
  end;
  if gradeneedamount<0 then
  begin
    SysDialogs.ShowMessage( '请刷卡!');
    Exit;
  end;

   if StrToInt(edtNum.Text) <=0 then
  begin
    SysDialogs.ShowMessage( '请输入兑换数量!');
    edtNum.SetFocus;
    Exit;
  end;
   if vipamount - gradeneedamount * StrToInt(edtNum.Text)<0 then
   begin
    SysDialogs.ShowMessage('顾客卡积分不够兑换该礼品,请重新输入!');
    edtNum.SetFocus;
    Exit;
   end;

   if afternum < 0 then
  begin
    SysDialogs.ShowMessage('已超出库存量，请重新输入!');
    edtNum.SetFocus;
    Exit;
  end;

   if gradeneedamount = -1  then
  begin
    SysDialogs.ShowMessage('该顾客的卡等级不够兑换该礼品!');
    edtNum.SetFocus;
    Exit;
  end;

  with jcdsSave do
  begin
    close;
     Params.ParamByName('exchangelog.vipgiftid').Value := vipgiftid;
     Params.ParamByName('exchangelog.vipid').Value := vipid;
    //操作后，剩余的库存量
    Params.ParamByName('exchangelog.remainstoragequantity').Value := edtLeaveNum.Text;
    //消耗的积分
    chageamount := gradeneedamount * StrToInt(edtNum.Text);
    Params.ParamByName('exchangelog.vipamount').Value := chageamount;
    //兑换数量
    Params.ParamByName('exchangelog.quantity').Value := edtNum.Text;
    //操作后剩余的积分
    Params.ParamByName('exchangelog.remainvipamount').Value :=leaveamount;
    //备注
    Params.ParamByName('exchangelog.remarks').Value :=  mmoRemark.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      //SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtNum.SetFocus;
      end
      else
      begin
        _vipcard := vipBaseCard;
        _vipcard.decrementamount(chageamount);
        cardresult := _vipcard.writeCard;
        while cardresult <> 0 do
          begin
            SysDialogs.Warning(_vipcard.getErrorInfo(cardresult)+',请放好VIP卡!');
            cardresult:=_vipcard.writeCard;
          end;

       log := '顾客:'+edtCoustomername.Text+' 以'+ inttostr(gradeneedamount * StrToInt(edtNum.Text))
          +' 积分兑换了'+edtNum.Text+'个礼品,礼品名称:'+nvhlpVipGiftname.Text
          +', 兑换前库存 '+ inttostr(leaveNum)
          + ', 兑换后库存 '+ inttostr(afternum)
          +',顾客积分'+ inttostr(vipamount)
          +',顾客剩下积分'+ inttostr(leaveamount)
          +', 备注;'+mmoRemark.Text ;
        SysLog.WriteLog('礼品库存管理', '顾客积分兑换', log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage('礼品兑换成功！');
//        if (sResult=null) or (Trim(sResult)='')  then
//          SysDialogs.ShowMessage('礼品兑换成功！')
//        else
//          SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmVipGiftexchange.edtNumChange(Sender: TObject);
begin
  inherited;
  if StrToInt(edtNum.Text)>0 then
  begin
     leaveamount := vipamount - gradeneedamount * StrToInt(edtNum.Text);
     //edtVipAmount.Text := IntToStr(leaveamount);
     lblTakeamount.Caption :=IntToStr(gradeneedamount * StrToInt(edtNum.Text));
  end;
  afternum := leaveNum - StrToInt(edtNum.Text);
  if afternum < 0 then
  begin
    SysDialogs.Warning('兑换数量已超出库存,请重新输入！');
     edtNum.SetFocus;
     Exit;
  end;
  edtLeaveNum.Text := IntToStr(afternum);

end;

procedure TfrmVipGiftexchange.FormCreate(Sender: TObject);
begin
  inherited;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);

  try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;

end;

procedure TfrmVipGiftexchange.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TfrmVipGiftexchange.nvhlpVipGiftnameChange(Sender: TObject);
begin
  inherited;
  if not(nvhlpVipGiftname.Text ='') then
  begin
    nvhlpVipGiftname.Params.ParamValues['filter_GED_v!enddate']:= FormatDateTime('yyyy-mm-dd',Now) ;
  end;
end;

procedure TfrmVipGiftexchange.nvhlpVipGiftnameIdChange(Sender: TObject);
begin
  inherited;
  edtLeaveNum.Text := '0';
  edtNum.Text := '0';
  leaveNum :=0;
   if not (nvhlpVipGiftname.Text='' )then
  begin
    with jcdsVipgiftname do
    begin
       Active:=False;
      Params.ParamByName('vipgiftname').Value :=nvhlpVipGiftname.Text;
      Active := True;
       edtLeaveNum.Text := jcdsVipgiftname.FieldByName('quantity').AsString;
      if FieldByName('quantity').AsInteger<=0 then
      begin
        SysDialogs.ShowMessage('该礼品库存量为零，请重新选择！');
        nvhlpVipGiftname.Text := '';
        Exit;
      end;
    end;

    if (jcdsVipgiftname.RecordCount > 0) then
    begin
     vipgiftid :=jcdsVipgiftname.FieldByName('id').AsInteger;
      edtLeaveNum.Text := jcdsVipgiftname.FieldByName('quantity').AsString;
      //gradeneedamount :=  jcdsVipgiftname.FieldByName('needamount').AsInteger;
      leaveNum := jcdsVipgiftname.FieldByName('quantity').AsInteger;
      gradeneedamount := -1;//负数，证明没有获取到会员卡等级所需要的积分，需要刷卡
    end ;
//    else
//    begin
//      gradeneedamount := -1;
//      SysDialogs.ShowMessage('该顾客的卡等级不够兑换该礼品！');
//      Exit;
//    end;
    edtCoustomername.Text := '';
    edtVipgrade.Text :='';
    edtNum.Text := '0';
    edtVipAmount.Text :='';
    edtMoney.Text:='0';
    lblTakeamount.Caption :='0';
  end;
end;

procedure TfrmVipGiftexchange.vipcardfound(vipCard: TVipCard);
begin
    vipBaseCard := vipCard;
   with jcdsFindcardInfo do
  begin
    Active:=False;
    Params.ParamByName('cardno').Value := vipBaseCard.cardNo;
    Active := True;
  end;
  if jcdsFindcardInfo.RecordCount>0 then
  begin
    edtCoustomername.Text :=jcdsFindcardInfo.FieldByName('customername').AsString;
    customname :=jcdsFindcardInfo.FieldByName('customername').AsString;
    edtVipgrade.Text :=jcdsFindcardInfo.FieldByName('gragename').AsString;
    edtVipAmount.Text := CurrToStr(vipBaseCard.amount);
    edtMoney.Text := jcdsFindcardInfo.FieldByName('money').AsString;
    vipamount :=jcdsFindcardInfo.FieldByName('vipamount').AsInteger;
    vipid :=jcdsFindcardInfo.FieldByName('vipid').AsInteger;
    vipgrade:= jcdsFindcardInfo.FieldByName('vipgrade').AsString;
    coustemerid := jcdsFindcardInfo.FieldByName('customerid').AsInteger;
    edtNum.Text := '0';
    lblTakeamount.Caption :='0';


    if  StrToInt( edtVipAmount.Text) <=0 then
    begin
      SysDialogs.ShowMessage('该卡的卡积分不够兑换该礼品!');
      edtNum.SetFocus;
      Exit;
    end;

  end
  else
  begin
    edtNum.Text := '0';
    lblTakeamount.Caption :='0';
    SysDialogs.ShowMessage('该卡已不是正常状态,请核对！');
    Exit;
  end;

  if not (nvhlpVipGiftname.Text='' )then
  begin
    with jcdsVipgiftname do
    begin
       Active:=False;
      Params.ParamByName('vipgiftname').Value :=nvhlpVipGiftname.Text;
      if not( coustemerid =0 )then
      begin
       Params.ParamValues['vipgradeid']:= vipgrade;
      end;
      Active := True;
    end;

    if (jcdsVipgiftname.RecordCount > 0) then
    begin
      edtLeaveNum.Text := jcdsVipgiftname.FieldByName('quantity').AsString;
      gradeneedamount :=  jcdsVipgiftname.FieldByName('needamount').AsInteger;
      leaveNum := jcdsVipgiftname.FieldByName('quantity').AsInteger;
    end
    else
    begin
      gradeneedamount := -1;
      SysDialogs.ShowMessage('该顾客的卡等级不够兑换该礼品！');
      Exit;
    end;
  end;

end;

end.
