unit UFrmInsureReturnend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, ImgList, Buttons, ExtCtrls;

type
  TFrmInsureReturnend = class(TSimpleEditForm)
    bvlticketreceipt: TBevel;
    pnlinsurereceipt: TPanel;
    lblinsurenum_: TLabel;
    lblinsurenum: TLabel;
    lblinsurereceivablenum_: TLabel;
    lblinsurereceivablenum: TLabel;
    Label5: TLabel;
    lblinsuretotalnum: TLabel;
    pnlrr: TPanel;
    bvlrr: TBevel;
    lblreason: TLabel;
    mmoreason: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsureReturnend: TFrmInsureReturnend;

implementation

{$R *.dfm}

procedure TFrmInsureReturnend.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  self.ModalResult:=mrok;
end;

end.
