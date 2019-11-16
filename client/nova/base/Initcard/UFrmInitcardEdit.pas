unit UFrmInitcardEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls, NovaEdit,
  NovaComboBox, Buttons, ExtCtrls, ImgList, CardManage,UICcardRW;

type
  TFrmInitEdit = class(TSimpleEditForm,IBaseCardfound)
    Label1: TLabel;
    lblcardno: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    cbbtype: TNovaComboBox;
    jsonCDSInitSave: TjsonClientDataSet;
    edtcardno: TNovaEdit;
    otherinfo: TMemo;
    chkAutoInc: TCheckBox;
    grp1: TGroupBox;
    mmoCardInfo: TMemo;
    btnWriteCard: TBitBtn;
    lbl1: TLabel;
    NovaEdtSerial: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbtypeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    // anagecardclass:Tmanagecardclass;
    procedure iccardfound(icCard:TBaseCard);
  public
    { Public declarations }
    id, orgid, createby, endcardno: LongWord;
    createtime: TDatetime;
    flag: boolean;
    baseCard : TBaseCard;
    writecard : Integer;
  end;

var
  FrmInitEdit: TFrmInitEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInitEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
  _icCard : TBaseCard;
begin
  if (cbbtype.ItemIndex < 0) then
  begin
    SysDialogs.Warning('��ѡ������');
    edtcardno.SetFocus;
    exit;
  end;
  if (trim(edtcardno.Text) = '') then
  begin
    SysDialogs.Warning('����д����');
    edtcardno.SetFocus;
    exit;
  end;
  if Trim(NovaEdtSerial.Text) = '' then
  begin
    SysDialogs.Warning('û��Ӳ�����к�,���ܱ���,������ˢ����');
    edtcardno.SetFocus;
    exit;
  end;
  if Length(edtcardno.Text) <> edtcardno.MaxLength then
  begin
    ShowMessage('���ų���ӦΪ'+inttostr(edtcardno.MaxLength)+',���������룡');
    Exit;
  end;
  _icCard := baseCard;
  if  _icCard.isnew = False then
  begin
    ShowMessage('�ÿ��Ѿ�ʹ�ù������ܽ��г�ʼ������ȷ�ϡ�');
    Exit;
  end;
  with jsonCDSInitSave do
  begin                                                             
    Close;
    Params.ParamByName('count').Value := 1;
    Params.ParamByName('initcard.id').Value := id;
    Params.ParamByName('initcard.orgid').Value := orgid;
    Params.ParamByName('initcard.createby').Value := createby;
    Params.ParamByName('initcard.createtime').Value := DateTimeToStr
      (createtime);
    Params.ParamByName('initcard.cardno').Value := edtcardno.Text;
    Params.ParamByName('initcard.cardtype').Value := TCommInfo
      (cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    Params.ParamByName('initcard.serialnumber').Value := NovaEdtSerial.Text;
    Params.ParamByName('initcard.otherinfo').Value := otherinfo.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtcardno.SetFocus;
      end
      else
      begin
         // ������\��ʻԱ��\����Ա��\�����\Ա����\���㿨
        if (cbbtype.ItemIndex = 0) then // ������
        begin
          setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
          _icCard.cardtype := Tcardtypes.VEHICLEREPORT;
        end
        else if (cbbtype.ItemIndex = 1) then // ��ʻԱ��
        begin
          setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
          _icCard.cardtype := Tcardtypes.DRIVER;
        end
        else if (cbbtype.ItemIndex = 2) then // ����Ա��
        begin
          setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
          _icCard.cardtype := Tcardtypes.STEWARD;
        end
        else if (cbbtype.ItemIndex = 3) then // �����
        begin
          setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
          _icCard.cardtype := Tcardtypes.VIP;
        end
        else if (cbbtype.ItemIndex = 4) then // Ա����
        begin
          setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
          _icCard.cardtype := Tcardtypes.USER;
        end
        else // ���㿨
        begin
          setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
          _icCard.cardtype := Tcardtypes.VEHICLEUNIT;
        end;
        _icCard.cardNo := Trim(edtcardno.Text);  //��ȡIC������
        writecard := _icCard.writeCard;//��IC�����Ÿ������ͱ��浽IC������
        while writecard <> 0 do
        begin
          SysDialogs.Warning(_icCard.getErrorInfo(writecard)+',��ź�IC������ȷ������д����');
          writecard:=_icCard.writecard;
        end;
      //Self.NovaEdtSerial.Text := IntToStr(SysInfo.CardManage.CardSequence);
        mmoCardInfo.Lines.Add('���ţ�' + edtcardno.Text + 'д���ɹ���');
      // mmoCardInfo.Lines.Add('Ӳ�����кţ�'+edtcardno.Text+'д���ɹ���');


        if  chkAutoInc.Checked  then
        begin
          edtcardno.Text:=inttostr(StrToInt(edtcardno.Text)+1);
          //���ų�����󳤶ȣ�����������
          if Length(edtcardno.Text) > edtcardno.MaxLength then
          begin
             chkAutoInc.Checked := False;
             Exit; //�˳�
          end;
          while Length(edtcardno.Text) <> edtcardno.MaxLength do
          begin
            edtcardno.Text := '0' + edtcardno.Text;
          end;
          NovaEdtSerial.Clear;
         // btnWriteCard.Enabled:=true;
        end
        else
        begin
          id := Params.ParamByName('id').Value;
          ModalResult := mrok;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���ܿ���Ϣ���ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmInitEdit.cbbtypeChange(Sender: TObject);
begin
  inherited;
  edtcardno.Clear;
  if (cbbtype.ItemIndex = 0) then
  begin
    edtcardno.MaxLength := SysInfo.curBillLength.Items['Vehicle'];
  end
  else if (cbbtype.ItemIndex = 1) then // ��ʻԱ��
    edtcardno.MaxLength:=SysInfo.curBillLength.Items['Driver']
  else if (cbbtype.ItemIndex = 2) then // ����Ա��
    edtcardno.MaxLength:=SysInfo.curBillLength.Items['Steward']
  else if (cbbtype.ItemIndex = 3) then // �����
    edtcardno.MaxLength:=SysInfo.curBillLength.Items['Vip']
  else if (cbbtype.ItemIndex = 4) then // Ա����
    edtcardno.MaxLength:=SysInfo.curBillLength.Items['Userinfo']
  else // ���㿨
    edtcardno.MaxLength:=SysInfo.curBillLength.Items['Unit'];
end;

procedure TFrmInitEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtype.Active := false;
  cbbtype.Active := true;

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

procedure TFrmInitEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;

end;

procedure TFrmInitEdit.iccardfound(icCard: TBaseCard);
begin
  NovaEdtSerial.Text := IntToStr(icCard.internalSerialNo);
  baseCard := icCard;
end;

end.
