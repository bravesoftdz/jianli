unit UFrmHandInvoicesNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet;

type
  TFrmHandInvoicesNo = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    NovaEdtInvoicesNo: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHandInvoicesNo: TFrmHandInvoicesNo;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmHandInvoicesNo.bbtnSaveClick(Sender: TObject);
begin
  ModalResult := mrok;
end;

end.
