unit UFrmSellReserveSeatend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ufrmsellticketend, StdCtrls, NovaComboBox, NovaEdit, ExtCtrls,
  Generics.Collections,jsonClientDataSet,UDMPublic, DB, DBClient;

type
  TFrmSellReserveSeatend = class(Tfrmsellticketend)
    pnlservicefee: TPanel;
    lblservicefee_: TLabel;
    lblservicefee: TLabel;
    jcdsfindSeatReserve: TjsonClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    selectedSeats:TList<Word>;
    curSchedulePlanId:int64;
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
  FrmSellReserveSeatend: TFrmSellReserveSeatend;

implementation

{$R *.dfm}

{ TFrmSellReserveSeatend }

function TFrmSellReserveSeatend.checkreceipt(needpay: Currency): boolean;
begin
  result:=inherited;
end;

constructor TFrmSellReserveSeatend.Create(AOwner: TComponent);
begin
  inherited;
  curSchedulePlanId:=0;
  selectedSeats:=TList<Word>.create;
end;

function TFrmSellReserveSeatend.execute(
  cdsticketbuffer: TjsonClientDataSet): boolean;
begin
  result:=true;
end;

function TFrmSellReserveSeatend.getContextHint(winControl: TWinControl): String;
begin
  result:=inherited;
end;

function TFrmSellReserveSeatend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function TFrmSellReserveSeatend.getfullThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function TFrmSellReserveSeatend.getSellWayreceivablenum: Currency;
begin
  result:=0;
  with jcdsfindSeatReserve do
  begin
    if not active then exit;
    First;
    while not eof do
    begin
      result:=result+FieldByName('serviceprice').AsCurrency;
      next;
    end;
  end;
end;

function TFrmSellReserveSeatend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet): Currency;
begin
  result:=0;
  with jcdsfindSeatReserve do
  begin
    First;
    while not eof do
    begin
      if (cdsticketbuffer.FieldByName('scheduleplanid').AsLargeInt=curSchedulePlanId)
        and (cdsticketbuffer.FieldByName('seatno').AsInteger=FieldByName('seatno').AsInteger) then
      begin
        result:=FieldByName('serviceprice').AsCurrency;
        break;
      end;
      next;
    end;
  end;
end;

function TFrmSellReserveSeatend.reset: boolean;
begin
  result:=inherited;
end;

function TFrmSellReserveSeatend.show: boolean;
var seatno:word;
    seatnos:TStringBuilder;
begin
  seatnos:=TStringBuilder.Create;
  with jcdsfindSeatReserve do
  begin
    active:=false;
    Params.ParamValues['filter_EQL_t!scheduleplanid']:=curSchedulePlanId;
    for seatno in selectedSeats do
    begin
      seatnos.Append(',').Append(inttostr(seatno));
    end;
    seatnos.Remove(0,1).Insert(0,'(').Append(')');
    Params.ParamValues['filter_INS_t!seatno']:=seatnos.ToString;
    active:=true;
  end;
  lblservicefee.Caption:=CurrToStr(getSellWayreceivablenum);
  pnlservicefee.Visible:=(self.curTicketNum>0);
end;

end.
