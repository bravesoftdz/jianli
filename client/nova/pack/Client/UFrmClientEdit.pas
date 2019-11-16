unit UFrmClientEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet, Services,
  NovaHComboBox, ImgList;

type
  TfrmClientEdit = class(TSimpleEditForm)
    jcdsSave: TjsonClientDataSet;
    lbl1: TLabel;
    nvedtcontacter: TNovaEdit;
    lbl7: TLabel;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    lbl13: TLabel;
    nvedtadress: TNovaEdit;
    lbl5: TLabel;
    mmoRemark: TMemo;
    lbl11: TLabel;
    edtEmail: TNovaEdit;
    lbl15: TLabel;
    lblunitid: TLabel;
    nvcbbtype: TNovaComboBox;
    Label1: TLabel;
    Label2: TLabel;
    nvedtcode: TNovaEdit;
    Label3: TLabel;
    nvedtfixphone: TNovaEdit;
    Label4: TLabel;
    nvedtmobilephone: TNovaEdit;
    Label5: TLabel;
    Label6: TLabel;
    nvedtname: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvedtnameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Foperationid: Integer;

  public
    { Public declarations }
    isedit: boolean;
    id: Integer;
    createby, orgid, createtime, code, idcard, tname, certificateno, birthday,
      certificatetype, education, adress, mobilphone, familyphone, remarks,
      email, educationname, certificatetypename, synccode: string;
    isactive, islocaldelete: boolean;
    property operationid: Integer read Foperationid;
  end;

var
  frmClientEdit: TfrmClientEdit;

implementation

uses UDMPublic, PubFn;
{$R *.dfm}

procedure TfrmClientEdit.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: Integer;
  sResult, log, optype: String;
begin
  inherited;
  if nvcbbtype.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ������!');
    nvcbbtype.SetFocus;
    exit;
  end;

  if (Trim(nvedtname.Text) = '') then
  begin
    SysDialogs.ShowMessage('���Ʋ���Ϊ��!');
    nvedtname.SetFocus;
    exit;
  end;

  if (Trim(nvedtcode.Text) = '') then
  begin
    SysDialogs.ShowMessage('��ƴ����Ϊ��!');
    nvedtcode.SetFocus;
    exit;
  end;

  if (Length(Trim(nvedtcode.Text)) >nvedtcode.MaxLength) then
  begin
    SysDialogs.ShowMessage('��ƴ����!');
    nvedtcode.SetFocus;
    exit;
  end;

  with jcdsSave do
  begin
    close;

    Params.ParamByName('client.email').Value := edtEmail.Text;
    if self.edittype = Tedittype.update then
    begin
      Params.ParamByName('client.id').Value := id;
      Params.ParamByName('client.createtime').Value := createtime;
      Params.ParamByName('client.createby').Value := createby;
      Params.ParamByName('client.orgid').Value := orgid;
      Params.ParamByName('client.synccode').Value := synccode;
    end
    else
    begin
      Params.ParamByName('client.orgid').Value := SysInfo.LoginUserInfo.orgid;
    end;
    Params.ParamByName('client.type').Value := nvcbbtype.GetSelectCode;
    if rbMan.Checked then
      Params.ParamByName('client.sex').Value := '��';
    if rbGrile.Checked then
      Params.ParamByName('client.sex').Value := 'Ů';

    Params.ParamByName('client.name').Value := nvedtname.Text;
    Params.ParamByName('client.contacter').Value := nvedtcontacter.Text;
    Params.ParamByName('client.code').Value := nvedtcode.Text;
    Params.ParamByName('client.fixphone').Value := nvedtfixphone.Text;
    Params.ParamByName('client.mobilephone').Value := nvedtmobilephone.Text;
    Params.ParamByName('client.address').Value := nvedtadress.Text;

    Params.ParamByName('client.remarks').Value := mmoRemark.Text;
    Params.ParamByName('client.isactive').Value := 'true'; // �Ƿ񼤻�
    Params.ParamByName('client.islocaldelete').Value := 'false';
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvedtname.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          optype := '�޸�';

        end
        else
        begin
          optype := '���';

        end;
        log := optype + '����:' + nvcbbtype.Text + '����:' + nvedtname.Text +
          ', ��ƴ:' + nvedtcode.Text + '��ϵ��:' + nvedtcontacter.Text + ' �̻�:' +
          nvedtfixphone.Text + ' �ƶ��绰;' + nvedtmobilephone.Text + '�����ʼ�:' +
          edtEmail.Text + ' ��ַ' + nvedtadress.Text + ' ��ע:' + mmoRemark.Text;
        SysLog.WriteLog('�а��ͻ���������', optype, log);
        log := '';
        optype := '';
        id := Params.ParamByName('clientid').Value;
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

procedure TfrmClientEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbtype.Active := False;
  nvcbbtype.Active := True;
end;

procedure TfrmClientEdit.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.add then
  begin
    nvcbbtype.ItemIndex := 0;
  end;

end;

procedure TfrmClientEdit.nvedtnameChange(Sender: TObject);
begin
  inherited;
  nvedtcode.Text := GetPyChar(Trim(nvedtname.Text));

end;

end.
