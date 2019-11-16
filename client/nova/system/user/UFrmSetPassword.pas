unit UFrmSetPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Services, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit;

type
  TFrmSetPassword = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    NovaEdtPassword: TNovaEdit;
    NovaEdtPassword2: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag : Boolean;
  end;

var
  FrmSetPassword: TFrmSetPassword;

implementation

{$R *.dfm}

procedure TFrmSetPassword.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(NovaEdtPassword.Text)='' then
  begin
    SysDialogs.Warning('����������');
    NovaEdtPassword.SetFocus;
    exit;
  end;
  if trim(NovaEdtPassword2.Text)='' then
  begin
    SysDialogs.Warning('������ȷ������');
    NovaEdtPassword2.SetFocus;
    exit;
  end;
  if trim(NovaEdtPassword2.Text)<>trim(NovaEdtPassword.Text) then
  begin
    NovaEdtPassword2.Clear;
    NovaEdtPassword.Clear;
    SysDialogs.Warning('��2����������벻һ�������������룡');
    NovaEdtPassword.SetFocus;
    exit;
  end;
  ModalResult:=mrok;
end;

end.
