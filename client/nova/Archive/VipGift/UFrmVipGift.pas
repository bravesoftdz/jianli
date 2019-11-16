unit UFrmVipGift;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
   ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit,Services,NvPrnDbgeh, NvDbgridEh,
  UFrmVipGiftEdit,UFrmVipGiftput,UFrmVipGiftStorage,UFrmVipGiftExchangelog,
  UFrmVipGiftexchange, NovaCheckedComboBox, UICcardRW, CardManage;

type
  TfrmVipGift= class(TSimpleCRUDForm, Ivipcardfound)
    jcdsDelete: TjsonClientDataSet;
    grp3: TGroupBox;
    grp8: TGroupBox;
    nvdbgrdhTicke: TNvDbgridEh;
    grp1: TGroupBox;
    grp2: TGroupBox;
    tlb2: TToolBar;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    btn11: TToolButton;
    btn12: TToolButton;
    nvdbgrdh1: TNvDbgridEh;
    jcdsTickeDetail: TjsonClientDataSet;
    dsTicketResult: TDataSource;
    lbldate: TLabel;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvcbbvipgrade: TNovaCheckedComboBox;
    edtBegina: TNovaEdit;
    edtEnda: TNovaEdit;
    lbl2: TLabel;
    lbl4: TLabel;
    jcdsInputStorage: TjsonClientDataSet;
    jcdsFindcardInfo: TjsonClientDataSet;
    grp4: TGroupBox;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lblName: TLabel;
    lblGrade: TLabel;
    lblMoney: TLabel;
    lblAmount: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure vipcardfound(vipCard:TVipCard);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtn3Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TvipBaseCard : TVipCard;
    cardGrade : TCardGrade ;
    Tcustomername,Tvipgradename,Tvipgrage,Tmongy:string;
    Tvipamount,Tvipid,Tcustomerid :Integer;
  end;

var
  frmVipGift: TfrmVipGift;

implementation
uses UDMPublic,PubFn;

{$R *.dfm}


procedure TfrmVipGift.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbvipgrade.Active := False;
  nvcbbvipgrade.Active := True;
  dtpstartdate.Date:= Now;
  dtpenddate.Date:=Now;

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


   //出入库明细
procedure TfrmVipGift.tbtn3Click(Sender: TObject);
begin
  inherited;
    try
      frmVipGiftStorage := TfrmVipGiftStorage.Create(self);
      with frmVipGiftStorage do
      begin
        Caption:='礼品出入库明细';
        dtpstartdate.Date:= Now-30;
        dtpenddate.Date := Now;
        nvcbbOperation.Active := False;
        nvcbbOperation.Active := True;
        if  (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
       begin
        nvhlpVipGiftname.Text := jcdsResult.FieldByName('name').AsString;
        with jcdsFindDetail do
        begin
          Active:=False;
          Params.ParamValues['startdate'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime)+' 00:00:00';
          Params.ParamValues['enddate'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime)+' 23:59:59';
          Params.ParamByName('vipgiftname').Value  := nvhlpVipGiftname.Text;
           Params.ParamValues['operation']:= nvcbbOperation.GetSelectID;
          Active := True;
        end;
       end;
        ShowModal;
      end;
    finally
      FreeAndNil(frmVipGiftStorage);
    end;
end;

//兑换明细查询
procedure TfrmVipGift.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  try
      frmVipGiftExchangelog := TfrmVipGiftExchangelog.Create(self);
      with frmVipGiftExchangelog do
      begin
        Caption:='兑换查询';
        if  (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
       begin
        nvhlpVipGiftname.Text := jcdsResult.FieldByName('name').AsString;
        with jcdsEcahangeDetail do
        begin
          Active:=False;
          Params.ParamValues['filter_GED_vg!createtime']
            :=  formatdatetime('yyyy-mm-dd hh:mm:ss',Now-30)+' 00:00:00';
          Params.ParamValues['filter_LED_vg!createtime']
            :=  formatdatetime('yyyy-mm-dd hh:mm:ss',Now)+' 23:59:59';
          Params.ParamByName('filter_EQS_vt!name').Value
            :=  nvhlpVipGiftname.Text;
          Active := True;
        end;
       end;
        ShowModal;
      end;
    finally
      FreeAndNil(frmVipGiftExchangelog);
    end;
end;

procedure TfrmVipGift.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
    // 删除
  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该礼品类型吗？') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' 删除 会员礼品类型 名称：'+jcdsResult.FieldByName('name').AsString;
      SysLog.WriteLog('会员礼品类型管理', '删除', log);
      log:='';
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
//    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

 //修改
procedure TfrmVipGift.tbtnEditClick(Sender: TObject);
var item:Integer;s:string;
List: TStrings;
begin
  inherited;

  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
  begin
    frmVipGiftEdit := TfrmVipGiftEdit.Create(self);
    try
      with frmVipGiftEdit do
      begin
        Caption:='修改会员礼品信息';
        isedit:= True;
        id :=  jcdsResult.FieldByName('id').AsInteger;
        createby:=jcdsResult.FieldByName('createby').AsString;
        createtime:=jcdsResult.FieldByName('createtime').AsString;
        names := jcdsResult.FieldByName('name').AsString;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        mmoRemark.Text:=jcdsResult.FieldByName('remarks').AsString;
        remarks := jcdsResult.FieldByName('remarks').AsString;
        edtValuation.Text := jcdsResult.FieldByName('valuation').AsString;
        valuation := jcdsResult.FieldByName('valuation').AsString;
        oldamount:=jcdsResult.FieldByName('needamount').AsString;
        mount := jcdsResult.FieldByName('needamount').AsString;
        dtpstartdate.Date :=jcdsResult.FieldByName('startdate').AsDateTime;
        startdate:= jcdsResult.FieldByName('startdate').AsString;
        dtpenddate.Date :=jcdsResult.FieldByName('enddate').AsDateTime;
        enddate:= jcdsResult.FieldByName('enddate').AsString;
        quantity := jcdsResult.FieldByName('quantity').AsString;
        oldvipgradename:= jcdsResult.FieldByName('vipgradename').AsString;
        types := jcdsResult.FieldByName('vipgrade').AsString; //(1,2,3)
        List:= TStringList.Create;
        List.CommaText := types;
        for s in types do
        begin
         if s=',' then
          Continue;

          item := strtoint(s);
          nvcbbvipgrade.SetCheck(item,true);
        end;
        List.Free;


        ShowModal;
        if ModalResult = mrok then
         begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id',id,[] );
         end;


      end;
    finally
      FreeAndNil(frmVipGiftEdit);
    end;
  end;
end;

procedure TfrmVipGift.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)
  then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    dtpenddate.SetFocus;
    exit;
  end;
  //查询
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamByName('startdate').Value
      := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamByName('enddate').Value
      := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Params.ParamValues['vipgrade']:= nvcbbvipgrade.GetSelectID;
    Params.ParamByName('beginamount').Value := edtBegina.Text;
    Params.ParamByName('endamount').Value  := edtEnda.Text ;
    Active := True;
  end;
end;

procedure TfrmVipGift.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  //添加
   frmVipGiftEdit := TfrmVipGiftEdit.Create(self);
  with frmVipGiftEdit do
  begin
    Caption := '添加会员礼品类型';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
end;

  //礼品兑换
procedure TfrmVipGift.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
  begin
      if jcdsResult.FieldByName('enddate').AsDateTime<Trunc(Now) then
      begin
        SysDialogs.ShowMessage('该礼品活动已结束，请重新选择！');
        Exit;
      end;

      if jcdsResult.FieldByName('quantity').AsInteger <=0 then
      begin
        SysDialogs.ShowMessage('该礼品已兑换完毕，请重新选择！');
        Exit;
      end;
  end;
  frmVipGiftexchange := TfrmVipGiftexchange.Create(self);
  try
    with frmVipGiftexchange do
    begin
      if jcdsResult.Active and (jcdsResult.RecordCount > 0) then
      begin
        vipgiftid :=  Self.jcdsResult.FieldByName('id').AsInteger;
        nvhlpVipGiftname.Id := Self.jcdsResult.FieldByName('id').AsInteger;
        nvhlpVipGiftname.Text := Self.jcdsResult.FieldByName('name').AsString;
        edtLeaveNum.Text := Self.jcdsResult.FieldByName('quantity').AsString;
        gradeneedamount :=-1;//负数，证明没有获取到会员卡等级所需要的积分，需要刷卡
      end;

      if ShowModal = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id',id,[] );
      end;
    end;
  finally
    FreeAndNil(frmVipGiftexchange);
  end;
end;

procedure TfrmVipGift.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
  begin
    frmVipGiftput := TfrmVipGiftput.Create(self);
    try
      with frmVipGiftput do
      begin
        Caption:='礼品入库';
        isoutput:= False;
        vipgiftid :=  jcdsResult.FieldByName('id').AsInteger;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        edtLeaveNum.Text := jcdsResult.FieldByName('quantity').AsString;
        operation := '0';
        lblNum.Caption := '入库数量';

        ShowModal;
        if ModalResult = mrok then
         begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id',id,[] );
         end;


      end;
    finally
      FreeAndNil(frmVipGiftEdit);
    end;
  end;
end;

procedure TfrmVipGift.ToolButton51Click(Sender: TObject);
var quantity:Integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
  begin
    quantity := jcdsResult.FieldByName('quantity').AsInteger;
    if quantity<=0 then
    begin
      Exit;
    end;

    frmVipGiftput := TfrmVipGiftput.Create(self);
    try
      with frmVipGiftput do
      begin
        Caption:='礼品出库';
        isoutput:= True;
        vipgiftid :=  jcdsResult.FieldByName('id').AsInteger;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        edtLeaveNum.Text := jcdsResult.FieldByName('quantity').AsString;
        operation:= '1';
        lblNum.Caption := '出库数量';

        ShowModal;
        if ModalResult = mrok then
         begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id',id,[] );
         end;
      end;
    finally
      FreeAndNil(frmVipGiftEdit);
    end;
  end;

end;

  //读取卡号 ,查询vip卡相关信息
procedure TfrmVipGift.vipcardfound(vipCard: TVipCard);
var cardgarde:Integer;
begin
  TvipBaseCard := vipCard;
  with jcdsFindcardInfo do
  begin
    Active:=False;
    Params.ParamByName('cardno').Value := TvipBaseCard.cardNo;
    Active := True;
  end;
  if jcdsFindcardInfo.RecordCount>0 then
  begin
    Tcustomername :=jcdsFindcardInfo.FieldByName('customername').AsString;
    Tvipgradename :=jcdsFindcardInfo.FieldByName('gragename').AsString;
    Tvipamount := StrToInt(CurrToStr(TvipBaseCard.amount));
    Tvipid :=jcdsFindcardInfo.FieldByName('vipid').AsInteger;
    Tvipgrage:= jcdsFindcardInfo.FieldByName('vipgrade').AsString;
    Tcustomerid := jcdsFindcardInfo.FieldByName('customerid').AsInteger;
    Tmongy := jcdsFindcardInfo.FieldByName('money').AsString;
    lblName.Caption :=Tcustomername;
    lblName.Font.Color := clRed;
    lblMoney.Caption := CurrToStr(TvipBaseCard.money);
    lblMoney.Font.Color := clRed;
    lblAmount.Caption :=CurrToStr(TvipBaseCard.amount);
    lblAmount.Font.Color := clRed;
    lblGrade.Font.Color := clRed;

    cardgarde :=  Integer(TvipBaseCard.cardGrade );

    if cardgarde =0 then
    lblGrade.Caption :='一卡通'
    else if cardgarde=1 then
    lblGrade.Caption :='普卡'
    else if cardgarde =2 then
    lblGrade.Caption :='金卡' ;
  end
  else
  begin
    lblName.Caption :='';
    lblMoney.Caption := '';
    lblAmount.Caption := '';
    lblGrade.Caption := '';
    SysDialogs.ShowMessage('该卡已不是正常状态,请核对！');
    Exit;
  end;
//   ShowMessage('主页面'+vipBaseCard.cardNo);
end;

  //页面销毁时  把读卡器注销
procedure TfrmVipGift.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

end.
