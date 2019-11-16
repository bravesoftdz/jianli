unit Ufrmchangeticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ufrmsellticketend, StdCtrls, NovaComboBox, NovaEdit, ExtCtrls, DB,
  DBClient, jsonClientDataSet,Generics.Collections;

type
  Tfrmchangeticketend = class(Tfrmsellticketend)
    pnlservicefee: TPanel;
    lblservicefee_: TLabel;
    lblservicefee: TLabel;
    lblserviceprice: TLabel;
    lblpropotion: TLabel;
    nvedtservicefee: TNovaEdit;
    Label1: TLabel;
    lblTicketreturn: TLabel;
    Label3: TLabel;
    lblinsurereturn: TLabel;
    bvl1: TBevel;
  private
    { Private declarations }
    ispropotion:boolean; //服务费是否按比例收取
    defaultserviceprice:Currency;  //默认服务费
    function getCurServicefee:Currency;
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
  frmchangeticketend: Tfrmchangeticketend;

implementation
uses pubfn,services;

{$R *.dfm}

function Tfrmchangeticketend.checkreceipt(needpay: Currency): boolean;
begin
  result:=inherited;
end;

constructor Tfrmchangeticketend.Create(AOwner: TComponent);
begin
  inherited;
  ispropotion:=getParametervalue('1501',sysinfo.LoginUserInfo.OrgID)='1';
  lblpropotion.Visible:=ispropotion;
  defaultserviceprice:=StrToCurrDef(getParametervalue('1502',sysinfo.LoginUserInfo.OrgID),0);
  nvedtservicefee.Text:=currtostr(defaultserviceprice);
end;

function Tfrmchangeticketend.execute(cdsticketbuffer:TjsonClientDataSet): boolean;
begin
  result:=true;
end;

function Tfrmchangeticketend.getContextHint(winControl: TWinControl): String;
begin
  result:=inherited;
end;

function Tfrmchangeticketend.getCurServicefee: Currency;
begin
  if ispropotion then
  begin
    if getCurTicketNum=0 then
      result:=0
    else
      result:=getCurTicketNum*Round(defaultserviceprice*strtocurrdef(lblTicketreturn.Caption,0)/getCurTicketNum/100);
  end
  else
    result:=defaultserviceprice*getCurTicketNum;
end;

function Tfrmchangeticketend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function Tfrmchangeticketend.getfullThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function Tfrmchangeticketend.getSellWayreceivablenum: Currency;
begin
  result:=getCurServicefee-StrToCurrDef(lblinsurereturn.Caption,0)-StrToCurrDef(lblTicketreturn.Caption,0);
end;

function Tfrmchangeticketend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet): Currency;
begin
  if ispropotion then
  begin
//    result:=Round(defaultserviceprice*cdsticketbuffer.FieldByName('price').AsCurrency/100)
    if getCurTicketNum=0 then
      result:=0
    else
      result:=Round(defaultserviceprice*strtocurrdef(lblTicketreturn.Caption,0)/getCurTicketNum/100)
  end
  else
    result:=defaultserviceprice;
end;

function Tfrmchangeticketend.reset: boolean;
begin
  lblTicketreturn.Caption:='';
  lblinsurereturn.Caption:='';
  lblservicefee.Caption:='';
  nvedtservicefee.Text:='0';
  result:=inherited;
end;

function Tfrmchangeticketend.show: boolean;
begin
  result:=inherited;
  nvedtservicefee.Text:=currtostr(defaultserviceprice);
  lblservicefee.Caption:=CurrToStr(getCurServicefee);
end;

end.
