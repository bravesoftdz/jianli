unit CheckTickets;

interface

uses Classes, SysUtils, DB, Generics.Collections, Forms, jsonClientDataSet,
  Services,
  FunctionItemIntf, UDMPublic, Variants, StrUtils, NovaPrint;

type
  TCheckTickets = class(TComponent)
  private

    FbillPrint: TNovaPrint;
    // ≥ı ºªØ∆±∫≈
    function initBillNo(): boolean;

  public
    constructor Create();
    property billPrint: TNovaPrint read FbillPrint;
  end;

implementation

uses UFrmCheckTicket;

{ TCheckTicket }

constructor TCheckTickets.Create;
begin
  if (not SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')) or
    (not SysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill')) then
  begin
    initBillNo();
  end;
  FrmCheckTicket := TFrmCheckTicket.Create(Self, nil);
  Services.SysMainForm.ShowForm(FrmCheckTicket);
end;

function TCheckTickets.initBillNo: boolean;
var
  functionParm: TFunctionItemParameters;
begin
  functionParm := TFunctionItemParameters.Create;
  functionParm.CommaText := 'BalanceBill';
  SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),
    functionParm);
  Result := SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill');
end;

end.
