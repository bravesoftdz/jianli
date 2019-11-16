unit UFrmViproomcheckinEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList, DBGridEhGrouping, ToolWin, GridsEh, DBGridEh,
  NvDbgridEh, Menus, UICcardRW, CardManage;

type
  TfrmViproomcheckinEdit = class(TSimpleEditForm, Ivipcardfound)
    jcdsSave: TjsonClientDataSet;
    lbl2: TLabel;
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
    pnl1: TPanel;
    grp4: TGroupBox;
    nvdbgrdhResult: TNvDbgridEh;
    grp3: TGroupBox;
    grp5: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    grp6: TGroupBox;
    grp7: TGroupBox;
    tlb1: TToolBar;
    nvdbgrdh3: TNvDbgridEh;
    dsTicketResult: TDataSource;
    jcdsTickeDetail: TjsonClientDataSet;
    lbl1: TLabel;
    edtName: TNovaEdit;
    pmMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    jcdsFindcardInfo: TjsonClientDataSet;
    lbl3: TLabel;
    edtVipgrade: TNovaEdit;
    lbl4: TLabel;
    edtVipAmount: TNovaEdit;
    edtcardno: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure dsTicketResultDataChange(Sender: TObject; Field: TField);
    procedure vipcardfound(vipCard:TVipCard);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtcardnoChange(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    _vipBaseCard : TVipCard;
  public
    { Public declarations }
   vipid,id:integer;
   cardno:string;
    property operationid:Integer read Foperationid;
  end;

var
  frmViproomcheckinEdit: TfrmViproomcheckinEdit;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmViproomcheckinEdit.bbtnSaveClick(Sender: TObject);
 var  msg,sellids,ticketsellno: String;
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;

  if Trim(edtcardno.Text)='' then
  begin
    SysDialogs.Warning('��ˢ����');
     edtcardno.SetFocus;
    exit
  end;
  if edtName.Text='' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѳ�������״̬���޷��Ǽǣ�');
    Exit;
  end;

   sellids := '';
  with jcdsTickeDetail do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        if FieldByName('ischecked').AsBoolean then
        begin
          sellids := sellids + FieldByName('sellid').AsString + ',';
          ticketsellno :=  ticketsellno+FieldByName('ticketno').AsString + ',';
        end;
        Next;
      end;
      EnableControls;
    end;
  end;

  if sellids='' then
  begin
    SysDialogs.Warning('��ѡ��Ʊ��');
    exit
  end;

  with jcdsSave do
  begin
    close;
    Params.ParamByName('vipid').Value := vipid;
    Params.ParamByName('ticketsellids').Value := sellids;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        SysDialogs.ShowError(sResult);
        edtcardno.SetFocus;
      end
      else
      begin
        optype:='�Ǽ�';
        log := ' ��Ա :'+edtName.Text+', �Ѿ��������ң�'
        +',vip����'+edtcardno.Text
        +',����Ʊ��:'+ticketsellno;

        SysLog.WriteLog('��Ʊ����->��Ա������ҵǼ�', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�Ǽ�ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmViproomcheckinEdit.dsTicketResultDataChange(Sender: TObject;
  Field: TField);
  var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
   if not assigned(Field) then exit;
   if field.DataSet.FieldByName('ischecked').Value =True then
   begin
      if field.DataSet.fieldbyname('isinroom').AsBoolean then
      begin
        field.DataSet.FieldByName('ischecked').Value:=False;
      end;
  end;
end;

procedure TfrmViproomcheckinEdit.edtcardnoChange(Sender: TObject);
var results:String ;
begin
  inherited;
  with jcdsTickeDetail do
  begin
    Active:=False;
    Params.ParamByName('vipcardno').Value  := edtcardno.Text ;
    Active := True;
  end;
end;

//��ȡ���� ,��ѯvip�������Ϣ
procedure TfrmViproomcheckinEdit.vipcardfound(vipCard: TVipCard );
var grade,amouts:Integer;
begin
  _vipBaseCard := vipCard;
  grade:= Integer(vipCard.cardGrade);
  if grade =0 then
  begin
    edtName.Text:='';
    edtVipgrade.Text:='';
    edtVipAmount.Text:='';
    edtcardno.Text:='';
    SysDialogs.Warning('һ��ͨ���ܽ������ң�');
    exit
  end
  else
  if grade=1 then
    edtVipgrade.Text :='�տ�'
  else
  if grade =2 then
    edtVipgrade.Text:='��' ;

  edtVipAmount.Text:= CurrToStr(vipCard.amount);
  with jcdsFindcardInfo do
  begin
    Active:=False;
    Params.ParamByName('cardno').Value := _vipBaseCard.cardNo;
    Active := True;
  end;
  if jcdsFindcardInfo.RecNo>=0 then
  begin
    vipid :=jcdsFindcardInfo.FieldByName('vipid').AsInteger;
    edtName.Text :=jcdsFindcardInfo.FieldByName('customername').AsString;
  end;
  if Trim(edtName.Text)='' then
  begin
    SysDialogs.ShowMessage('�ÿ��Ѳ�������״̬���޷��Ǽǣ�');
  end;

  edtcardno.Text:= vipCard.cardNo;
end;



procedure TfrmViproomcheckinEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TfrmViproomcheckinEdit.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

end.
