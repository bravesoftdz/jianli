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
    defaultThroughControl:TList<TWinControl>;//���辭���Ŀؼ�(Enter) ����Ʊ���洫��
    fullThroughControl:TList<TWinControl>;//ȫ�������Ŀؼ�(+) ����Ʊ���洫��
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

    procedure setCurTicketNum(const AValue: integer);//��ǰƱ��
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

    property curTicketNum:integer read getCurTicketNum write setCurTicketNum;//��ǰƱ��
    property cdsSchedule:TjsonClientDataSet read getCdsSchedule write setCdsSchedule;

    property totalTicketReceivablenum:Currency read getTotalTicketreceivablenum write setTotalTicketReceivablenum;//��ǰ��ƱӦ��+���泵ƱӦ��+���泵Ʊ�����
    property totalTicketNum:integer read getTotalticketnum write setTotalticketnum; //�ϼ���Ʊ��
    property totalInsureReceivableNum:Currency read getTotalinsurereceivablenum write setTotalinsurereceivablenum; //�ϼ��۱��ս��
    property totalInsureNum:integer read getTotalInsurenum write setTotalInsurenum;//�ϼ��۱�����
    property isShowEdit:integer read getIsShowEdit write setIsShowEdit;//�Ƿ���ʾ�༭��
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
