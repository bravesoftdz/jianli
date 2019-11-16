unit Ufrmpatchsellticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ufrmsellticketend, StdCtrls, NovaComboBox, NovaEdit, ExtCtrls,
  Generics.Collections,PubFn,Services,jsonClientDataSet;

type
  Tfrmpatchsellticketend = class(Tfrmsellticketend)
    pnlservicefee: TPanel;
    lblservicefee_: TLabel;
    lblservicefee: TLabel;
    nvedtservicefee: TNovaEdit;
    chkservicefee: TCheckBox;
    procedure nvedtservicefeeChange(Sender: TObject);
  private
    { Private declarations }
    defaultservicefee:Currency; //Single;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function getfullThroughControl():TList<TWinControl>;override;
    function getdefaultThroughControl():TList<TWinControl>;override;
    function getSellWayreceivablenum:Currency;override;
    function show():boolean;override;
    function execute(cdsticketbuffer:TjsonClientDataSet):boolean;override;
    function reset():boolean;override;
    function checkreceipt(needpay:Currency):boolean;override;
    function getContextHint(winControl: TWinControl):String;override;
    function getServicefee(cdsticketbuffer:TjsonClientDataSet):Currency;override;
  end;

var
  frmpatchsellticketend: Tfrmpatchsellticketend;

implementation

uses SellTicket;

{$R *.dfm}

function Tfrmpatchsellticketend.checkreceipt(needpay: Currency): boolean;
begin
  result:=inherited;
end;

constructor Tfrmpatchsellticketend.Create(AOwner: TComponent);
begin
  inherited;
  defaultservicefee:=0;
  nvedtservicefee.Text:='0';
  nvedtservicefeeChange(nil);
  pnlservicefee.Visible:=false;
  defaultservicefee:=StrToCurrDef(getParametervalue('1021',SysInfo.LoginUserInfo.OrgID),0);
  if defaultservicefee>0 then
  begin
    nvedtservicefee.Text:=CurrToStr(defaultservicefee);
    nvedtservicefeeChange(nil);
    pnlservicefee.Top:=pnlticketreceipt.Top+pnlticketreceipt.Height;
    pnlservicefee.Visible:=true;
  end;
end;

function Tfrmpatchsellticketend.execute(cdsticketbuffer:TjsonClientDataSet): boolean;
begin
  result:=inherited;
end;

function Tfrmpatchsellticketend.getContextHint(
  winControl: TWinControl): String;
begin
  if winControl=chkservicefee then //是否收取补票服务费
  begin
    result:='空格选择';
  end
  else if winControl=nvedtservicefee then //收钱框
  begin
    result:='↑增加数量、↓减小数量';
  end
  else
  begin
    result:=inherited;
  end;
end;

function Tfrmpatchsellticketend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function Tfrmpatchsellticketend.getfullThroughControl: TList<TWinControl>;
begin
  result:=inherited;
  result.Clear;
  result.Add(chkservicefee);
  if chkservicefee.Checked then
    result.Add(nvedtservicefee); //勾选服务费才将服务费金额加入
  result.Add(nvcbbpayment);
  result.Add(nvedtreceipt);
end;

function Tfrmpatchsellticketend.getSellWayreceivablenum: Currency;
begin
  if chkservicefee.Checked then
    result:=StrToCurrDef(lblservicefee.Caption,0)
  else
    result:=0;
end;

function Tfrmpatchsellticketend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet): Currency;
begin
  if chkservicefee.Checked then
    result:=StrToCurrDef(nvedtservicefee.Text,0)  //勾选服务费才将服务费金额加入
  else
    result:=0;
end;

procedure Tfrmpatchsellticketend.nvedtservicefeeChange(Sender: TObject);
begin
  inherited;
  if chkservicefee.Checked then
    lblservicefee.Caption:=CurrToStr(getCurTicketNum*StrToCurrDef(nvedtservicefee.Text,0))
  else
    lblservicefee.Caption:='0';
  if lblinsurereceivablenum.Visible then
  begin
    lblreceivablenum.Caption:=CurrToStr(StrToCurrDef(lblticketreceivablenum.Caption,0)
                                        +StrToCurrDef(lblinsurereceivablenum.Caption,0)
                                        +getSellWayreceivablenum
                                        );
    nvedtreceipt.Text :=  lblreceivablenum.Caption;
  end
  else
  begin
    lblreceivablenum.Caption:=CurrToStr(StrToCurrDef(lblticketreceivablenum.Caption,0)
                                        +getSellWayreceivablenum
                                        );
    nvedtreceipt.Text :=  lblreceivablenum.Caption;
  end;
  nvedtreceiptChange(nil);
end;

function Tfrmpatchsellticketend.reset: boolean;
begin
  result:=inherited;
end;

function Tfrmpatchsellticketend.show: boolean;
begin
  result:=inherited;
  if not chkservicefee.Checked then
    chkservicefee.Checked:=true;
  nvedtservicefee.Text:=CurrToStr(defaultservicefee);
  nvedtservicefeeChange(nil);
  pnlservicefee.Visible:=(self.curTicketNum>0);
end;

end.
