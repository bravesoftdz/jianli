unit Ufrmsellwayend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls,Generics.Collections,SellWayEnd,jsonClientDataSet,
  UFrmSellTicket, NovaEdit;

type
  Tfrmsellwayend = class(TFrame,ISellWayEnd)
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
    nvedtticketreceivablenum: TNovaEdit;
    procedure nvedtticketreceivablenumChange(Sender: TObject);
  private
    { Private declarations }
    FCurTicketNum:integer;
    FcdsSchedule:TjsonClientDataSet;
    FtotalTicketReceivablenum:Currency;
    FtotalTicketNum:integer;
    FisShowEdit:integer;
    FtotalInsureReceivableNum:Currency;
    FtotalInsureNum:integer;
  protected
    FrmSellTicket:Tfrmsellticket;
  public
    { Public declarations }
    defaultThroughControl:TList<TWinControl>;//必需经过的控件(Enter) 由售票界面传入
    fullThroughControl:TList<TWinControl>;//全部经过的控件(+) 由售票界面传入
    constructor Create(AOwner: TComponent); override;
    function getfullThroughControl():TList<TWinControl>; dynamic;
    function getdefaultThroughControl():TList<TWinControl>; dynamic;
    function getSellWayreceivablenum:Currency;dynamic;
    function show():boolean;dynamic;
    function execute(cdsticketbuffer:TjsonClientDataSet):boolean;dynamic;
    function reset():boolean;dynamic;
    function checkreceipt(needpay:Currency):boolean;dynamic;
    function getContextHint(winControl: TWinControl):String;dynamic;
    function getServicefee(cdsticketbuffer:TjsonClientDataSet):Currency;dynamic;

    procedure setCurTicketNum(const AValue: integer);//当前票数
    function getCurTicketNum:integer;
    procedure setCdsSchedule(const AValue:TjsonClientDataSet);
    function getCdsSchedule:TjsonClientDataSet;

    procedure setTotalTicketReceivablenum(const AValue:Currency);
    function getTotalTicketreceivablenum:Currency;
    procedure setTotalticketnum(const AValue:integer);
    procedure setIsShowEdit(const AValue:integer);
    function getTotalticketnum:integer;
    function  getIsShowEdit:integer;
    procedure setTotalinsurereceivablenum(const AValue:Currency);
    function getTotalinsurereceivablenum:Currency;
    procedure setTotalInsurenum(const AValue:integer);
    function getTotalInsurenum:integer;

    property curTicketNum:integer read getCurTicketNum write setCurTicketNum;//当前票数
    property cdsSchedule:TjsonClientDataSet read getCdsSchedule write setCdsSchedule;

    property totalTicketReceivablenum:Currency read getTotalTicketreceivablenum write setTotalTicketReceivablenum;//当前车票应收+缓存车票应收+缓存车票服务费
    property totalTicketNum:integer read getTotalticketnum write setTotalticketnum; //合计售票数
    property totalInsureReceivableNum:Currency read getTotalinsurereceivablenum write setTotalinsurereceivablenum; //合计售保险金额
    property totalInsureNum:integer read getTotalInsurenum write setTotalInsurenum;//合计售保险数
    property isShowEdit:integer read getIsShowEdit write setIsShowEdit;//是否显示编辑框
  end;

implementation

{$R *.dfm}

{ Tfrmsellwayend }

function Tfrmsellwayend.checkreceipt(needpay:Currency): boolean;
begin
  result:= true;
end;

constructor Tfrmsellwayend.Create(AOwner: TComponent);
begin
  inherited;
  FrmSellTicket:=TFrmSellTicket(AOwner);
  FCurTicketNum:=0;
end;

function Tfrmsellwayend.execute(cdsticketbuffer:TjsonClientDataSet): boolean;
begin
  result:=true;
end;

function Tfrmsellwayend.getCdsSchedule: TjsonClientDataSet;
begin
  result:=FcdsSchedule;
end;

function Tfrmsellwayend.getContextHint(winControl: TWinControl):String;
begin
  result:='';
end;

function Tfrmsellwayend.getCurTicketNum: integer;
begin
  result:=FCurTicketNum;
end;

function Tfrmsellwayend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=TList<TWinControl>.Create;
end;

function Tfrmsellwayend.getfullThroughControl: TList<TWinControl>;
begin
  result:=TList<TWinControl>.Create;
end;

function Tfrmsellwayend.getSellWayreceivablenum: Currency;
begin
  result:=0;
end;

function Tfrmsellwayend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet):Currency;
begin
  result:=0;
end;

function Tfrmsellwayend.getTotalInsurenum: integer;
begin
  Result:=FtotalInsureNum;
end;

function Tfrmsellwayend.getTotalinsurereceivablenum: Currency;
begin
  result:=FtotalInsureReceivableNum;
end;

function Tfrmsellwayend.getTotalticketnum: integer;
begin
  result:=FtotalTicketNum;
end;

function Tfrmsellwayend.getIsShowEdit: integer;
begin
  result:=FisShowEdit;
end;

function Tfrmsellwayend.getTotalTicketreceivablenum: Currency;
begin
  result:=FtotalTicketReceivablenum;
end;

procedure Tfrmsellwayend.nvedtticketreceivablenumChange(Sender: TObject);
begin
lblreceivablenum.Caption:=CurrToStr(strtoint(nvedtticketreceivablenum.Text)+totalInsurereceivablenum+getSellWayreceivablenum);

end;

function Tfrmsellwayend.reset: boolean;
begin
  lblticketnum.Caption:='0';
  lblticketreceivablenum.Caption:='0';
  nvedtticketreceivablenum.Text:='0';
  lblreceivablenum.Caption:='0';
end;

procedure Tfrmsellwayend.setCdsSchedule(const AValue: TjsonClientDataSet);
begin
  FcdsSchedule:=AValue;
end;

procedure Tfrmsellwayend.setCurTicketNum(const AValue: integer);
begin
  FCurTicketNum:=avalue;
end;

procedure Tfrmsellwayend.setTotalInsurenum(const AValue: integer);
begin
  FtotalInsureNum:=AValue;
end;

procedure Tfrmsellwayend.setTotalinsurereceivablenum(const AValue: Currency);
begin
  FtotalInsureReceivableNum:=AValue;
end;

procedure Tfrmsellwayend.setTotalticketnum(const AValue: integer);
begin
  FtotalTicketNum:=AValue;
end;

procedure Tfrmsellwayend.setIsShowEdit(const AValue: integer);
begin
  FisShowEdit:=AValue;
end;

procedure Tfrmsellwayend.setTotalTicketReceivablenum(const AValue: Currency);
begin
  FtotalTicketReceivablenum:=AValue;
end;

function Tfrmsellwayend.show: boolean;
begin
  result:=true;

  if isShowEdit=1 then
  begin
     lblticketreceivablenum.Visible:=false;
     nvedtticketreceivablenum.Visible:=true;
//     nvedtticketreceivablenum.SetFocus;
  end
  else
  begin
     nvedtticketreceivablenum.Visible:=false;
     lblticketreceivablenum.Visible:=true;

  end;
  lblticketreceivablenum.Caption:=CurrToStr(totalTicketreceivablenum);
  nvedtticketreceivablenum.Text:= CurrToStr(totalTicketreceivablenum);
  lblticketnum.Caption:=inttostr(totalticketnum);
  lblreceivablenum.Caption:=CurrToStr(totalTicketreceivablenum+totalInsurereceivablenum+getSellWayreceivablenum);
end;

end.
