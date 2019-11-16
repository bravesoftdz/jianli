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
    SysDialogs.ShowInfo('��ǰѡ�еĳ�Ʊ��Ʊʱ�����Ҫ�˵�VIP���С��뽫VIP���ŵ���������');
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
