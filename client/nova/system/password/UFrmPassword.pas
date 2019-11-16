unit UFrmPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet;

type
  TFrmPassword = class(TSimpleEditForm)
    edtoldpassword: TNovaEdit;
    edtnewpassword: TNovaEdit;
    edtpassword: TNovaEdit;
    lbloldpassword: TLabel;
    lblnewpassword: TLabel;
    lblpassword: TLabel;
    jsonCDSPasswordsave: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPassword: TFrmPassword;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmPassword.bbtnSaveClick(Sender: TObject);
var nResult: Integer;
    sResult: string;
begin
  inherited;
  with jsonCDSPasswordsave do
  begin
    Close;
    if trim(edtoldpassword.Text) = '' then
    begin
      SysDialogs.Warning('����д�����룡');
      edtoldpassword.SetFocus;
      exit;
    end;
    if Trim(edtnewpassword.Text) = '' then
    begin
      SysDialogs.Warning('����д�����룡');
      edtnewpassword.SetFocus;
      exit;
    end;
    if Trim(edtpassword.Text) = '' then
    begin
      SysDialogs.Warning('����дȷ�ϵ����룡');
      edtpassword.SetFocus;
      exit;
    end;
    if (Trim(edtpassword.Text) <> Trim(edtpassword.Text)) then
    begin
      SysDialogs.Warning('��������ĵ����벻��ͬ��');
      edtpassword.SetFocus;
      exit;
    end;

    Params.ParamByName('user.password').Value := Trim(edtoldpassword.Text);
    Params.ParamByName('newpassword').Value := Trim(edtnewpassword.Text);
    Params.ParamByName('pass').Value := Trim(edtpassword.Text);
    
    try
      Execute;
      nResult := Params.ParamByName('nResult').Value;
      sResult := Params.ParamByName('sResult').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtoldpassword.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�����޸�ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

end.
