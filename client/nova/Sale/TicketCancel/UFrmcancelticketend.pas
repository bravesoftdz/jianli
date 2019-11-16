unit UFrmcancelticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ImgList;

type
  TFrmcancelticketend = class(TSimpleEditForm)
    pnlinsurereceipt: TPanel;
    lblinsurenum_: TLabel;
    lblinsurenum: TLabel;
    lblinsurereceivablenum_: TLabel;
    lblinsurereceivablenum: TLabel;
    pnlticketreceipt: TPanel;
    lblticketnum_: TLabel;
    lblticketnum: TLabel;
    lblticketreceivablenum_: TLabel;
    lblticketreceivablenum: TLabel;
    bvlticketreceipt: TBevel;
    pnlrr: TPanel;
    bvlrr: TBevel;
    lblreceivablenum_: TLabel;
    lblreceivablenum: TLabel;
    lblreason: TLabel;
    mmoreason: TMemo;
    lblservicefee_: TLabel;
    lblservicefee: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    canceltovipcard:Boolean;
  end;

var
  Frmcancelticketend: TFrmcancelticketend;

implementation

uses UFrmTicketCancel,Services;

{$R *.dfm}

procedure TFrmcancelticketend.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if canceltovipcard and (FrmTicketCancel.curvipCard=nil) then
  begin
    SysDialogs.ShowInfo('当前选中的车票废票时，余额要退到VIP卡中。请将VIP卡放到读卡器上');
    exit;
  end;
  self.ModalResult:=mrok;
end;

procedure TFrmcancelticketend.FormCreate(Sender: TObject);
begin
  inherited;
  canceltovipcard:=false;
end;

end.
