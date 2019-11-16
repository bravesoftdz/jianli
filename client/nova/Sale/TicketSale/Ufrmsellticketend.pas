unit Ufrmsellticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, NovaComboBox, NovaEdit, ExtCtrls,Generics.Collections,
  SellWayEnd,UDMPublic,Ufrmsellwayend,jsonClientDataSet;

type
  Tfrmsellticketend = class(Tfrmsellwayend)
    pnlinsurereceipt: TPanel;
    lblinsurenum_: TLabel;
    lblinsurenum: TLabel;
    lblinsurereceivablenum_: TLabel;
    lblinsurereceivablenum: TLabel;
    lblreceipt: TLabel;
    lblpayment: TLabel;
    lblchange: TLabel;
    lblchange_: TLabel;
    nvedtreceipt: TNovaEdit;
    nvcbbpayment: TNovaComboBox;
    pnlnetservicefee: TPanel;
    lbl3: TLabel;
    lblnetservicefee: TLabel;
    procedure nvedtreceiptChange(Sender: TObject);
    procedure nvcbbpaymentChange(Sender: TObject);
    procedure nvedtticketreceivablenumChange(Sender: TObject);
  private
    { Private declarations }
    netservicefee:Currency;
    netservicefee_jxs:Currency;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function getfullThroughControl():TList<TWinControl>; override;
    function getdefaultThroughControl():TList<TWinControl>; override;
    function getSellWayreceivablenum:Currency;override;
    function show():boolean;override;
    function execute(cdsticketbuffer:TjsonClientDataSet):boolean;override;
    function reset():boolean;override;
    function checkreceipt(needpay:Currency):boolean;override;
    function getContextHint(winControl: TWinControl):String;override;
    function getServicefee(cdsticketbuffer:TjsonClientDataSet):Currency;override;
  end;

implementation

uses PubFn,Services;

{$R *.dfm}

{ Tfrmsellticketend }

function Tfrmsellticketend.checkreceipt(needpay:Currency): boolean;
begin
if isShowEdit=1 then
  begin
     result:= (trim(nvedtreceipt.Text)<>'') and (StrToCurr(nvedtreceipt.Text)>0);
  end
  else
  begin
      result:= (trim(nvedtreceipt.Text)<>'') and (StrToCurr(nvedtreceipt.Text)>=needpay);
  end;
//  result:= (trim(nvedtreceipt.Text)<>'') and (StrToCurr(nvedtreceipt.Text)>=needpay);
end;

constructor Tfrmsellticketend.Create(AOwner: TComponent);
begin
  inherited;
  nvcbbpayment.Active:=true;
  lblnetservicefee.Caption:='0';
  pnlnetservicefee.Visible:=false;
  netservicefee:=StrToCurrDef(getParametervalue('1048',SysInfo.LoginUserInfo.OrgID),0);
  netservicefee_jxs:=StrToCurrDef(getParametervalue('1049',SysInfo.LoginUserInfo.OrgID),0);
end;

function Tfrmsellticketend.execute(cdsticketbuffer:TjsonClientDataSet): boolean;
begin
  result:=inherited;
end;

function Tfrmsellticketend.getContextHint(winControl: TWinControl):String;
begin
  if winControl=nvcbbpayment then //支付方式
  begin
    result:='↑↓切换';
  end
  else if winControl=nvedtreceipt then //收钱框
  begin
    result:='↑↓切换支付方式、Enter打印、+保存到购物车';
  end
  else
  begin
    result:=inherited;
  end;
end;

function Tfrmsellticketend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=inherited;
  result.Add(nvedtreceipt);

end;

function Tfrmsellticketend.getfullThroughControl: TList<TWinControl>;
begin
  result:=inherited;
  result.Add(nvcbbpayment);
  result.Add(nvedtticketreceivablenum);
  result.Add(nvedtreceipt);


end;

function Tfrmsellticketend.getSellWayreceivablenum: Currency;
begin
  if FrmSellTicket.chkSellNet.Checked and pnlnetservicefee.Visible then
  begin
    result:=StrToCurr(lblnetservicefee.Caption);
  end
  else
    result:=0;
end;

function Tfrmsellticketend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet): Currency;
begin
  if FrmSellTicket.chkSellNet.Checked and pnlnetservicefee.Visible then
  begin
    if (FrmSellTicket.nvhelpdepartstation.Id>0)
      and (FrmSellTicket.nvhelpdepartstation.HelpFieldValue['orgtype']='8') then
      result:=netservicefee_jxs
    else
      result:=netservicefee;
  end
  else
    result:=0;
end;

procedure Tfrmsellticketend.nvcbbpaymentChange(Sender: TObject);
begin
  inherited;
  //更新界面显示
  if nvcbbpayment.ItemIndex<>2 then  //贵宾卡支付
  begin
    lblreceipt.Visible:=True;
    nvedtreceipt.Visible:=true;
    if defaultThroughControl.Contains(nvcbbpayment) then
    begin
      defaultThroughControl.Remove(nvcbbpayment);
    end;
    if not defaultThroughControl.Contains(nvedtreceipt) then
    begin
      defaultThroughControl.Add(nvedtreceipt);
    end;
  end
  else
  begin
    lblreceipt.Visible:=false;
    nvedtreceipt.Visible:=false;
    if not defaultThroughControl.Contains(nvcbbpayment) then
    begin
      defaultThroughControl.Add(nvcbbpayment);
    end;
    if defaultThroughControl.Contains(nvedtreceipt) then
    begin
      defaultThroughControl.Remove(nvedtreceipt);
    end;
  end;
end;

procedure Tfrmsellticketend.nvedtreceiptChange(Sender: TObject);
begin
  if Trim(lblreceivablenum.Caption)='' then
    lblchange.Caption:='0'
  else if Trim(nvedtreceipt.Text)='' then
    lblchange.Caption:=CurrToStr(0-StrToCurr(lblreceivablenum.Caption))
  else
    lblchange.Caption:=CurrToStr(StrToCurr(nvedtreceipt.Text)-StrToCurr(lblreceivablenum.Caption));
end;

procedure Tfrmsellticketend.nvedtticketreceivablenumChange(Sender: TObject);
begin
  inherited;
//  lblchange.Caption:=CurrToStr(0-StrToCurr(lblreceivablenum.Caption));  原业务逻辑
  lblchange.Caption:=CurrToStr(StrToCurr(nvedtreceipt.text)-StrToCurr(lblreceivablenum.Caption));
  nvedtreceipt.Text :=lblreceivablenum.Caption;
end;

function Tfrmsellticketend.reset: boolean;
begin
  inherited;
  lblticketnum.Caption:='0';
  lblticketreceivablenum.Caption:='0';
  nvedtticketreceivablenum.Text:='0';
  lblreceivablenum.Caption:='0';
  nvcbbpayment.ItemIndex:=0;
  nvedtreceipt.Text:='';
  lblchange.Caption:='0';
end;

function Tfrmsellticketend.show: boolean;
var _netservicefee:Currency;
begin
  result:=inherited;
  if totalInsurenum>0 then
  begin
    lblinsurereceivablenum.Caption:=CurrToStr(totalinsurereceivablenum);
    lblinsurenum.Caption:=inttostr(totalInsurenum);
    pnlinsurereceipt.Visible:=true;
    pnlinsurereceipt.Top:=pnlticketreceipt.Top+pnlticketreceipt.Height;
  end
  else
  begin
    lblinsurereceivablenum.Caption:='0';
    lblinsurenum.Caption:='0';
    pnlinsurereceipt.Visible:=false;
  end;
  if (FrmSellTicket.curvipCard<>nil)
     and (StrToCurr(lblreceivablenum.Caption)<=FrmSellTicket.curvipCard.money) then
  begin
    nvcbbpayment.ItemIndex:=2; //余额购票
  end
  else
  begin
    nvcbbpayment.ItemIndex:=0;
  end;
  nvcbbpaymentChange(nil);

  _netservicefee:=0;
  if FrmSellTicket.chkSellNet.Checked then
  begin
    if (FrmSellTicket.nvhelpdepartstation.Id>0)
      and (FrmSellTicket.nvhelpdepartstation.HelpFieldValue['orgtype']='8') then
      _netservicefee:=netservicefee_jxs
    else
      _netservicefee:=netservicefee;
  end;
  if (_netservicefee>0) then
  begin
    lblnetservicefee.Caption:=CurrToStr(getCurTicketNum*_netservicefee);
    pnlnetservicefee.Top:=pnlticketreceipt.Top+pnlticketreceipt.Height;
    pnlnetservicefee.Visible:=True;
  end
  else
  begin
    lblnetservicefee.Caption:='0';
    pnlnetservicefee.Visible:=false;
  end;
  lblreceivablenum.Caption:=CurrToStr(totalTicketreceivablenum+totalInsurereceivablenum+getSellWayreceivablenum);
  if FrmSellTicket.cbautoreceipt.Checked then
  begin
      nvedtreceipt.Text:= lblreceivablenum.Caption;
  end
  else
  begin
       nvedtreceipt.Text:='0';
  end;

  nvedtreceiptChange(nil);
end;

end.
