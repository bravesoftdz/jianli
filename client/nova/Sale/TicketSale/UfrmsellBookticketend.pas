unit UfrmsellBookticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ufrmsellticketend, StdCtrls, NovaComboBox, NovaEdit, ExtCtrls,
  Generics.Collections,jsonClientDataSet,UDMPublic, DB, DBClient;

type
  TfrmsellBookticketend = class(Tfrmsellticketend)
    pnlservicefee: TPanel;
    lblservicefee_: TLabel;
    lblservicefee: TLabel;
  private
    { Private declarations }
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
  frmsellBookticketend: TfrmsellBookticketend;

implementation

{$R *.dfm}

{ TfrmsellBookticketend }

function TfrmsellBookticketend.checkreceipt(needpay: Currency): boolean;
begin
  result:=inherited;
end;

constructor TfrmsellBookticketend.Create(AOwner: TComponent);
begin
  inherited;
end;

function TfrmsellBookticketend.execute(
  cdsticketbuffer: TjsonClientDataSet): boolean;
begin
  result:=true;
end;

function TfrmsellBookticketend.getContextHint(winControl: TWinControl): String;
begin
  result:=inherited;
end;

function TfrmsellBookticketend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function TfrmsellBookticketend.getfullThroughControl: TList<TWinControl>;
begin
  result:=inherited;
end;

function TfrmsellBookticketend.getSellWayreceivablenum: Currency;
var bm:TBookmark;
begin
  result:=0;
  if cdsSchedule=nil then exit;
  with cdsSchedule do
  begin
    if not active then exit;
    DisableControls;
    bm:=GetBookmark;
    First;
    while not eof do
    begin
      if FieldByName('isselect').AsBoolean then
      begin
        result:=result+FieldByName('serviceprice').AsCurrency;
      end;
      next;
    end;
    GotoBookmark(bm);
    EnableControls;
  end;
end;

function TfrmsellBookticketend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet): Currency;
var bm:TBookmark;
begin
  result:=0;
  with cdsSchedule do
  begin
    DisableControls;
    bm:=GetBookmark;
    First;
    while not eof do
    begin
      if (cdsticketbuffer.FieldByName('scheduleplanid').AsLargeInt=FieldByName('scheduleplanid').AsLargeInt)
        and (cdsticketbuffer.FieldByName('seatno').AsInteger=FieldByName('seatno').AsInteger) then
      begin
        result:=FieldByName('serviceprice').AsCurrency;
        break;
      end;
      next;
    end;
    GotoBookmark(bm);
    EnableControls;
  end;
end;

function TfrmsellBookticketend.reset: boolean;
begin
  result:=inherited;
end;

function TfrmsellBookticketend.show: boolean;
var seatno:word;
    seatnos:TStringBuilder;
begin
  result:=inherited;
  lblservicefee.Caption:=CurrToStr(getSellWayreceivablenum);
  pnlservicefee.Visible:=(self.curTicketNum>0);
end;

end.
