unit UFrmCardissue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaCheckedComboBox, NovaComboBox, NovaHelp, UICcardRW;

type
  TFrmCardissue = class(TSimpleCRUDForm, IBaseCardfound)
    jcdstypename: TjsonClientDataSet;
    jcdsstatusname: TjsonClientDataSet;
    jcdsResultserialnumber: TWideStringField;
    jcdsResultcardno: TWideStringField;
    jcdsResultbillname: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdsResultissuename: TWideStringField;
    jcdsResultissueorgname: TWideStringField;
    jcdsResultissueip: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultbilltypeid: TLargeintField;
    jcdsResulttypeid: TLargeintField;
    jcdsResultissueby: TLargeintField;
    jcdsResultissueorgid: TLargeintField;
    jcdsResultstatusname: TWideStringField;
    jcdsResulttypename: TWideStringField;
    jcdsResultcardtypename: TWideStringField;
    lbserialnumber: TLabel;
    dtmfldResultvaliddate: TDateTimeField;
    dtmfldResultissuetime: TDateTimeField;
    dtmfldResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    lbl1: TLabel;
    lbl2: TLabel;
    cbbOrg: TNovaCheckedComboBox;
    lbl3: TLabel;
    jcdsResultCancel: TjsonClientDataSet;
    jcdsResultRecover: TjsonClientDataSet;
    jcdsResultReturn: TjsonClientDataSet;
    nvserialnumber: TNovaEdit;
    cbbtype: TNovaComboBox;
    cbbstatus: TNovaComboBox;
    lrgntfldResultcreateby: TLargeintField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultoutletsname: TWideStringField;
    lrgntfldResultticketoutletsid: TLargeintField;
    lbl4: TLabel;
    nvhlpticketoutlets: TNovaHelp;
    lbl5: TLabel;
    nvhlpcardno: TNovaHelp;
    fltfldResultmoney: TFloatField;
    fltfldResultvipamount: TFloatField;
    jcdslogout: TjsonClientDataSet;
    lrgntfldResultvipid: TLargeintField;
    fltfldResultcardcost: TFloatField;
    lrgntfldResultcustomerid: TLargeintField;
    jcdsgradename: TjsonClientDataSet;
    wdstrngfldResultgrade: TWideStringField;
    wdstrngfldResultgradename: TWideStringField;
    jcdsResultcertificateno: TWideStringField;
    jcdsResultmobilephone: TWideStringField;
    lbl6: TLabel;
    nvedtcertificateno: TNovaEdit;
    lbl7: TLabel;
    nvedtmobilephone: TNovaEdit;
    lbl8: TLabel;
    nvhlpvehicle: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbtypeChange(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
  private
    { Private declarations }
    procedure iccardfound(icCard:TBaseCard);
  public
    { Public declarations }
  end;

var
  FrmCardissue: TFrmCardissue;

implementation

uses Services, UFrmCardissueEdit, UFrmCardloss,
 UFrmFullCard, UFrmVipcardreturn,UFrmCardActive;
{$R *.dfm}

procedure TFrmCardissue.cbbtypeChange(Sender: TObject);
begin
  inherited;
  nvedtcertificateno.Visible:=cbbtype.ItemIndex=4;
  lbl6.Visible:=nvedtcertificateno.Visible;
  lbl7.Visible:=nvedtcertificateno.Visible;
  nvedtmobilephone.Visible:=nvedtcertificateno.Visible;



  //����
  nvhlpvehicle.Visible:=cbbtype.ItemIndex=1;
  lbl8.Visible:=nvhlpvehicle.Visible;
  if not nvhlpvehicle.Visible then
  begin
    nvhlpvehicle.Id:=0;
    nvhlpvehicle.Text:='';
  end;
  lbl8.Left:=610;
  lbl8.Top:=24;
  nvhlpvehicle.Left:=658 ;
  nvhlpvehicle.Top:=19;

end;

procedure TFrmCardissue.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmCardissue.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

procedure TFrmCardissue.FormShow(Sender: TObject);
begin
  inherited;
  cbbOrg.Active := False;
  cbbOrg.Active := True;

  cbbtype.Active := False;
  cbbtype.Active := True;

  cbbstatus.Active := False;
  cbbstatus.Active := True;
  lbl6.Visible:= False;
  nvedtcertificateno.Visible := False;
  lbl7.Visible:= False;
  nvedtmobilephone.Visible := False;
end;

procedure TFrmCardissue.iccardfound(icCard: TBaseCard);
begin
  nvhlpcardno.Text := icCard.cardNo;
  tbtnFilterClick(nil);
end;

procedure TFrmCardissue.tbtnCancelClick(Sender: TObject);
var FrmFullCard : TFrmFullcard;
begin
  inherited;
  with FrmFullCard do
  begin
    FrmFullCard := TFrmFullcard.create(Self);
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('cardno', FrmFullCard.cardno, []);
      FreeAndNil(FrmFullCard);
    end;
  end;
end;

procedure TFrmCardissue.tbtnDeleteClick(Sender: TObject);
var sResult : String;
    nResult, cardid : LongWord;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount <= 0 then
    Exit;
 { if jcdsResult.FieldByName('type').Value <> '3' then
  begin
      SysDialogs.ShowMessage('�ÿ����ǹ�����������˿���');
      Exit;
  end; }
  if not SysDialogs.Confirm('��Ϣ��ʾ',
    jcdsResult.FieldByName('typename').AsString+'��'+
     jcdsResult.FieldByName('billname').AsString+ ',����:'+
     jcdsResult.FieldByName('cardno').AsString+
    ',ȷ��Ҫ�˿���!') then
    exit;
  if jcdsResult.FieldByName('type').Value = '3' then
  begin
    with FrmVipcardreturn do
    begin
      FrmVipcardreturn := TFrmVipcardreturn.Create(self);
      Caption := '�˿�';
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('cardno', FrmVipcardreturn.cardno, []);
        FreeAndNil(FrmVipcardreturn);
      end;
    end;
  end else
  begin
    if jcdsResult.FieldByName('status').Value = '1' then
    begin
      SysDialogs.ShowMessage('�ÿ����ˣ�������ѡ��');
      Exit;
    end;
    if jcdsResult.FieldByName('status').Value = '2' then
    begin
      SysDialogs.ShowMessage('�ÿ��ѹ�ʧ�������˿���');
      Exit;
    end;
    if jcdsResult.FieldByName('status').Value = '3' then
    begin
      SysDialogs.ShowMessage('�ÿ���ע���������˿���');
      Exit;
    end;
    if jcdsResult.FieldByName('status').Value = '4' then
    begin
      SysDialogs.ShowMessage('�ÿ��ѹ��ڣ������˿���');
      Exit;
    end;
    with jcdsResultReturn do
    begin
      Close;
      Params.ParamValues['cardissue.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['vip.id'] := jcdsResult.FieldByName('vipid').AsString;
      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        SysDialogs.ShowMessage(sResult);
//        ShowModal;
        if (nResult = 1) then
        begin
          tbtnFilterClick(Sender);
//          jcdsResult.Locate('id', id, []);
        end;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('�˿�ʧ�ܣ�' + E.Message);
        end;
      end;
    end;
  end;
end;

procedure TFrmCardissue.tbtnEditClick(Sender: TObject);
var sResult : String;
    nResult,cardid : LongWord;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount <= 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ÿ������ˣ����ָܻ���');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '0' then
  begin
    SysDialogs.ShowMessage('�ÿ�������״̬��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '3' then
  begin
    SysDialogs.ShowMessage('�ÿ���ע�������ָܻ���');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '4' then
  begin
    SysDialogs.ShowMessage('�ÿ��ѹ��ڣ����ָܻ���');
    Exit;
  end;
   if jcdsResult.FieldByName('status').Value = '5' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѳ����¿������ָܻ���');
    Exit;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫ�ָ��ü�¼��!') then
    exit;
  if jcdsResult.FieldByName('type').Value = '3' then
  begin
    with FrmCardloss do
    begin
      FrmCardloss := TFrmCardloss.Create(self);
      Caption := '�ָ�';
      nvhlptypename.Text := jcdsResult.FieldByName('cardtypename').AsString;
      nvhlptypename.Enabled := False;
      nvhlpcardno.Text := jcdsResult.FieldByName('cardno').AsString;
      nvhlpcardno.Enabled := False;
      id := jcdsResult.FieldByName('id').AsInteger;
      vipid := jcdsResult.FieldByName('vipid').AsInteger;
      mmoremark.Text := '�����ҵ�';
      functiontype := 2;
//      SysMainForm.showFormModal(FrmCardloss,True);
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', id, []);
        FrmCardloss.Close;
      end;
    end;
  end else
  begin
    with jcdsResultRecover do
    begin
      Close;
      Params.ParamValues['cardissue.id'] := jcdsResult.FieldByName('id').AsString;
      params.ParamValues['cardissue.typeid'] := jcdsResult.FieldByName('typeid').AsString;
      Params.ParamValues['vip.id'] := jcdsResult.FieldByName('vipid').AsString;
      cardid := jcdsResult.FieldByName('id').AsInteger;
      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        SysDialogs.ShowMessage(sResult);
        if (nResult = 1) then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id', cardid, []);
        end;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('������¼�ָ�ʧ�ܣ�' + E.Message);
        end;
      end;
    end;
  end;
end;

procedure TFrmCardissue.tbtnFilterClick(Sender: TObject);
begin
  with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['filter_INS_c!issueorgid'] := cbbOrg.GetSelectID;
    Params.ParamValues['filter_LIKES_c!serialnumber'] := trim(nvserialnumber.Text);
    if Trim(cbbtype.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_c!type'] := '';
    end else
    begin
      Params.ParamValues['filter_EQS_c!type'] := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
    if Trim(cbbstatus.Text) = ''then
    begin
      Params.ParamValues['filter_EQS_c!status'] := '';
    end else
    begin
      Params.ParamValues['filter_EQS_c!status'] := TCommInfo(cbbstatus.Items.Objects[cbbstatus.ItemIndex]).Value;
    end;
    if Trim(nvhlpticketoutlets.Text) = ''then
    begin
      Params.ParamValues['filter_EQL_c!ticketoutletsid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_c!ticketoutletsid'] := nvhlpticketoutlets.Id
    end;
    if Trim(nvhlpcardno.Text) = ''then
    begin
      Params.ParamValues['filter_LIKES_c!cardno'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_c!cardno'] := nvhlpcardno.Text;
    end;
    if (cbbtype.ItemIndex=-1) or (cbbtype.ItemIndex=3) then
    begin
      if Trim(nvedtcertificateno.Text) = ''then
      begin
        Params.ParamValues['filter_EQS_cu!certificateno'] := '';
      end else
      begin
        Params.ParamValues['filter_EQS_cu!certificateno'] := nvedtcertificateno.Text;
      end;
      if Trim(nvedtmobilephone.Text) = ''then
      begin
        Params.ParamValues['filter_EQS_cu!mobilephone'] := '';
      end else
      begin
        Params.ParamValues['filter_EQS_cu!mobilephone'] := nvedtmobilephone.Text;
      end;
    end;
    //����
    if (cbbtype.ItemIndex=1) then
    begin
      if nvhlpvehicle.Id > 0  then
      begin
        Params.ParamValues['filter_EQL_c!typeid'] := nvhlpvehicle.Id;
      end
      else
      begin
        Params.ParamValues['filter_EQL_c!typeid'] := '';
      end;
    end
    else
    begin
      Params.ParamValues['filter_EQL_c!typeid'] := '';
    end;
    Active:= true;
  end;
end;

procedure TFrmCardissue.tbtnInsertClick(Sender: TObject);
var FrmCardissueEdit : TFrmCardissueEdit;
begin
  with FrmCardissueEdit do
  begin
    FrmCardissueEdit := TFrmCardissueEdit.Create(self);
    Caption := '���ܿ�����';
    isrecard := False;
    sign := True;
    functiontype := 1;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
      FreeAndNil(FrmCardissueEdit);
    end;
  end;

end;

procedure TFrmCardissue.tbtnSaveClick(Sender: TObject);
var sResult : string;
    nResult,cardid : Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount <= 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ÿ����ˣ�����ע����');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ÿ��ѹ�ʧ������ע����');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '3' then
  begin
    SysDialogs.ShowMessage('�ÿ�����ע��״̬��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '4' then
  begin
    SysDialogs.ShowMessage('�ÿ��ѹ��ڣ�����ע����');
    Exit;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫע���ü�¼��!') then
    exit;
  with jcdslogout do
  begin
    Close;
    Params.ParamValues['cardissue.id'] := jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['cardissue.status'] := jcdsResult.FieldByName('status').AsString;
    Params.ParamValues['vip.id'] := jcdsResult.FieldByName('vipid').AsString;
    cardid := jcdsResult.FieldByName('id').AsInteger;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id',cardid,[]);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('������¼ע��ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmCardissue.ToolButton50Click(Sender: TObject);
var sResult : String;
    nResult,cardid : LongWord;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount <= 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ÿ����ˣ����ܹ�ʧ��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѿ��ǹ�ʧ״̬��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '3' then
  begin
    SysDialogs.ShowMessage('�ÿ���ע�������ܹ�ʧ��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '4' then
  begin
    SysDialogs.ShowMessage('�ÿ��ѹ��ڣ����ܹ�ʧ��');
    Exit;
  end;
    if jcdsResult.FieldByName('status').Value = '5' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѳ����¿��������ٴι�ʧ��');
    Exit;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫ��ʧ�ü�¼��!') then
    exit;
  if jcdsResult.FieldByName('type').Value = '3' then
  begin
    with FrmCardloss do
    begin
      FrmCardloss := TFrmCardloss.Create(self);
      Caption := '��ʧ';
      nvhlptypename.Text := jcdsResult.FieldByName('cardtypename').AsString;
      nvhlptypename.Enabled := False;
      nvhlpcardno.Text := jcdsResult.FieldByName('cardno').AsString;
      nvhlpcardno.Enabled := False;
      id := jcdsResult.FieldByName('id').AsInteger;
      vipid := jcdsResult.FieldByName('vipid').AsInteger;
      mmoremark.Text := '���Ѷ�ʧ';
      functiontype := 1;
      SysMainForm.showFormModal(FrmCardloss,True);
      if ModalResult = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  end else
  begin
    with jcdsResultCancel do
    begin
      Close;
      Params.ParamValues['cardissue.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['vip.id'] := jcdsResult.FieldByName('vipid').AsString;
      cardid := jcdsResult.FieldByName('id').AsInteger;
      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        SysDialogs.ShowMessage(sResult);
        if (nResult = 1) then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id', cardid, []);
        end;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('���ܿ�������Ϣ��ʧʧ�ܣ�' + E.Message);
        end;
      end;
    end;
  end;

end;

procedure TFrmCardissue.ToolButton51Click(Sender: TObject);
var i : Integer;
  FrmCardissueEdit : TFrmCardissueEdit;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount <= 0) then
    Exit;
  if not (jcdsResult.FieldByName('type').Value = '3' ) then
  begin
    SysDialogs.ShowMessage('�ÿ����ǹ���������ܹ�ʧ������');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '0' then
  begin
    SysDialogs.ShowMessage('�ÿ�������״̬������Ҫ������');
    Exit;
  end
  else if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ÿ����ˣ����ܹ�ʧ������');
    Exit;
  end
  else if jcdsResult.FieldByName('status').Value = '3' then
  begin
    SysDialogs.ShowMessage('�ÿ���ע�������ܹ�ʧ����');
    Exit;
  end
  else if jcdsResult.FieldByName('status').Value = '4' then
  begin
    SysDialogs.ShowMessage('�ÿ��ѹ��ڣ����ܹ�ʧ����');
    Exit;
  end
  else if jcdsResult.FieldByName('status').Value = '5' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѿ��������������ٴβ���');
    Exit;
  end;

  with FrmCardissueEdit do
  begin
    FrmCardissueEdit := TFrmCardissueEdit.Create(self);
    Caption := '��ʧ����';
    isrecard := True;
    cbbtype.Text := jcdsResult.FieldByName('cardtypename').AsString;
    cbbtype.Enabled := False;
    //TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value := jcdsResult.FieldByName('type').AsString;
    nvhlpCustomer.Text := jcdsResult.FieldByName('typename').AsString;
    if jcdsResult.FieldByName('type').AsString = '3' then
    begin
      nvhlpCustomer.Id := jcdsResult.FieldByName('customerid').AsInteger;
    end else
    begin
      nvhlpCustomer.Id := jcdsResult.FieldByName('typeid').AsInteger;
    end;
    nvhlpCustomer.Enabled := False;
    for i := 0 to FrmCardissueEdit.cbbtype.Items.Count - 1 do
    begin
    try
    //TCommInfo(cbbgrade.Items.Objects[i]).Value
      if TCommInfo(cbbtype.Items.Objects[i]).Value= jcdsResult.FieldByName('type').AsString then
      begin
        cbbtype.ItemIndex:= i;
        break;
      end;
      except
      end;
    end;
    cbbvipgradefirst.ItemIndex:=jcdsResult.FieldByName('grade').AsInteger;
    sign := True;
    functiontype := 2;
    isrepair:=true; //�ǲ���
    viplastmoney:=jcdsResult.FieldByName('money').AsCurrency;
    viplastamont:=jcdsResult.FieldByName('vipamount').AsCurrency;
//    SysMainForm.showFormModal(FrmCardissueEdit,True);
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
      FreeAndNil(FrmCardissueEdit);
    end;
  end;
end;

//�����Ч��
procedure TFrmCardissue.ToolButton52Click(Sender: TObject);
var frmCardActive : TFrmCardActive;
begin
if jcdsResult.FieldByName('status').Value = '1' then
  begin
    SysDialogs.ShowMessage('�ÿ����ˣ����ܼ��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '2' then
  begin
    SysDialogs.ShowMessage('�ÿ��ѹ�ʧ�����ܼ��');
    Exit;
  end;
  if jcdsResult.FieldByName('status').Value = '3' then
  begin
    SysDialogs.ShowMessage('�ÿ���ע�������ܼ��');
    Exit;
  end;
    if jcdsResult.FieldByName('status').Value = '5' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѳ����¿������ܼ��');
    Exit;
  end;
  with frmCardActive do
  begin
    frmCardActive := TFrmCardActive.Create(self);
    nvhlptypename.Text := jcdsResult.FieldByName('cardtypename').AsString;
    nvhlpname.Text :=  jcdsResult.FieldByName('typename').AsString;
    nvhlpcardno.Text := jcdsResult.FieldByName('cardno').AsString;
    id := jcdsResult.FieldByName('id').AsString;
    olddate := jcdsResult.FieldByName('validdate').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
      FreeAndNil(frmCardActive);
    end;
  end;
end;

end.
