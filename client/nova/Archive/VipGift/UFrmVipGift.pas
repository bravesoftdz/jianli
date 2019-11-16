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
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;

end;


   //�������ϸ
procedure TfrmVipGift.tbtn3Click(Sender: TObject);
begin
  inherited;
    try
      frmVipGiftStorage := TfrmVipGiftStorage.Create(self);
      with frmVipGiftStorage do
      begin
        Caption:='��Ʒ�������ϸ';
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

//�һ���ϸ��ѯ
procedure TfrmVipGift.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  try
      frmVipGiftExchangelog := TfrmVipGiftExchangelog.Create(self);
      with frmVipGiftExchangelog do
      begin
        Caption:='�һ���ѯ';
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
    // ɾ��
  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0) then
  begin
    if not SysDialogs.Confirm('��ʾ','ȷ��Ҫɾ������Ʒ������') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' ɾ�� ��Ա��Ʒ���� ���ƣ�'+jcdsResult.FieldByName('name').AsString;
      SysLog.WriteLog('��Ա��Ʒ���͹���', 'ɾ��', log);
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
//    SysDialogs.ShowError('����ѡ����Ҫɾ���ļ�¼��');
  end;
end;

 //�޸�
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
        Caption:='�޸Ļ�Ա��Ʒ��Ϣ';
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
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtpenddate.SetFocus;
    exit;
  end;
  //��ѯ
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
  //���
   frmVipGiftEdit := TfrmVipGiftEdit.Create(self);
  with frmVipGiftEdit do
  begin
    Caption := '��ӻ�Ա��Ʒ����';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
end;

  //��Ʒ�һ�
procedure TfrmVipGift.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecordCount>0)  then
  begin
      if jcdsResult.FieldByName('enddate').AsDateTime<Trunc(Now) then
      begin
        SysDialogs.ShowMessage('����Ʒ��ѽ�����������ѡ��');
        Exit;
      end;

      if jcdsResult.FieldByName('quantity').AsInteger <=0 then
      begin
        SysDialogs.ShowMessage('����Ʒ�Ѷһ���ϣ�������ѡ��');
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
        gradeneedamount :=-1;//������֤��û�л�ȡ����Ա���ȼ�����Ҫ�Ļ��֣���Ҫˢ��
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
        Caption:='��Ʒ���';
        isoutput:= False;
        vipgiftid :=  jcdsResult.FieldByName('id').AsInteger;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        edtLeaveNum.Text := jcdsResult.FieldByName('quantity').AsString;
        operation := '0';
        lblNum.Caption := '�������';

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
        Caption:='��Ʒ����';
        isoutput:= True;
        vipgiftid :=  jcdsResult.FieldByName('id').AsInteger;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        edtLeaveNum.Text := jcdsResult.FieldByName('quantity').AsString;
        operation:= '1';
        lblNum.Caption := '��������';

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

  //��ȡ���� ,��ѯvip�������Ϣ
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
    lblGrade.Caption :='һ��ͨ'
    else if cardgarde=1 then
    lblGrade.Caption :='�տ�'
    else if cardgarde =2 then
    lblGrade.Caption :='��' ;
  end
  else
  begin
    lblName.Caption :='';
    lblMoney.Caption := '';
    lblAmount.Caption := '';
    lblGrade.Caption := '';
    SysDialogs.ShowMessage('�ÿ��Ѳ�������״̬,��˶ԣ�');
    Exit;
  end;
//   ShowMessage('��ҳ��'+vipBaseCard.cardNo);
end;

  //ҳ������ʱ  �Ѷ�����ע��
procedure TfrmVipGift.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

end.
