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
  chageamount,//���ĵĻ���
  cardresult: integer;
  sResult,log,optype: String;
begin
  inherited;
  if nvhlpVipGiftname.Text='' then
  begin
    SysDialogs.ShowMessage('������Ҫ�һ����������ƣ�');
    nvhlpVipGiftname.SetFocus;
    Exit;
  end;
  if gradeneedamount<0 then
  begin
    SysDialogs.ShowMessage( '��ˢ��!');
    Exit;
  end;

   if StrToInt(edtNum.Text) <=0 then
  begin
    SysDialogs.ShowMessage( '������һ�����!');
    edtNum.SetFocus;
    Exit;
  end;
   if vipamount - gradeneedamount * StrToInt(edtNum.Text)<0 then
   begin
    SysDialogs.ShowMessage('�˿Ϳ����ֲ����һ�����Ʒ,����������!');
    edtNum.SetFocus;
    Exit;
   end;

   if afternum < 0 then
  begin
    SysDialogs.ShowMessage('�ѳ��������������������!');
    edtNum.SetFocus;
    Exit;
  end;

   if gradeneedamount = -1  then
  begin
    SysDialogs.ShowMessage('�ù˿͵Ŀ��ȼ������һ�����Ʒ!');
    edtNum.SetFocus;
    Exit;
  end;

  with jcdsSave do
  begin
    close;
     Params.ParamByName('exchangelog.vipgiftid').Value := vipgiftid;
     Params.ParamByName('exchangelog.vipid').Value := vipid;
    //������ʣ��Ŀ����
    Params.ParamByName('exchangelog.remainstoragequantity').Value := edtLeaveNum.Text;
    //���ĵĻ���
    chageamount := gradeneedamount * StrToInt(edtNum.Text);
    Params.ParamByName('exchangelog.vipamount').Value := chageamount;
    //�һ�����
    Params.ParamByName('exchangelog.quantity').Value := edtNum.Text;
    //������ʣ��Ļ���
    Params.ParamByName('exchangelog.remainvipamount').Value :=leaveamount;
    //��ע
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
            SysDialogs.Warning(_vipcard.getErrorInfo(cardresult)+',��ź�VIP��!');
            cardresult:=_vipcard.writeCard;
          end;

       log := '�˿�:'+edtCoustomername.Text+' ��'+ inttostr(gradeneedamount * StrToInt(edtNum.Text))
          +' ���ֶһ���'+edtNum.Text+'����Ʒ,��Ʒ����:'+nvhlpVipGiftname.Text
          +', �һ�ǰ��� '+ inttostr(leaveNum)
          + ', �һ����� '+ inttostr(afternum)
          +',�˿ͻ���'+ inttostr(vipamount)
          +',�˿�ʣ�»���'+ inttostr(leaveamount)
          +', ��ע;'+mmoRemark.Text ;
        SysLog.WriteLog('��Ʒ������', '�˿ͻ��ֶһ�', log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage('��Ʒ�һ��ɹ���');
//        if (sResult=null) or (Trim(sResult)='')  then
//          SysDialogs.ShowMessage('��Ʒ�һ��ɹ���')
//        else
//          SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���ʧ�ܣ�' + E.Message);
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
    SysDialogs.Warning('�һ������ѳ������,���������룡');
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
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
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
        SysDialogs.ShowMessage('����Ʒ�����Ϊ�㣬������ѡ��');
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
      gradeneedamount := -1;//������֤��û�л�ȡ����Ա���ȼ�����Ҫ�Ļ��֣���Ҫˢ��
    end ;
//    else
//    begin
//      gradeneedamount := -1;
//      SysDialogs.ShowMessage('�ù˿͵Ŀ��ȼ������һ�����Ʒ��');
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
      SysDialogs.ShowMessage('�ÿ��Ŀ����ֲ����һ�����Ʒ!');
      edtNum.SetFocus;
      Exit;
    end;

  end
  else
  begin
    edtNum.Text := '0';
    lblTakeamount.Caption :='0';
    SysDialogs.ShowMessage('�ÿ��Ѳ�������״̬,��˶ԣ�');
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
      SysDialogs.ShowMessage('�ù˿͵Ŀ��ȼ������һ�����Ʒ��');
      Exit;
    end;
  end;

end;

end.
