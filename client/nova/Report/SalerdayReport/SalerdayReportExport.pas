unit SalerdayReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses SalerdayReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  salerdayReprt: TSalerdayReprt;
  salerOrgSyncReprt: TSalerOrgSyncReprt;
  syncSaleLocalReprt: TSyncSaleLocalReprt;
  orgInvoinceDetailReprt: TOrgInvoinceDetailReprt;
  balanceUnitInvoinces: TBalanceUnitInvoinces;
  presellMonthRevenue:TPresellMonthRevenue;
  vehicleIncome:TvehicleIncome;
  dayIncomeReprt:TdayIncomeReprt;
begin
  salerdayReprt := TSalerdayReprt.Create;
  Reg.RegisterFunctionItem(salerdayReprt);
  salerOrgSyncReprt := TSalerOrgSyncReprt.Create;
  Reg.RegisterFunctionItem(salerOrgSyncReprt);

  syncSaleLocalReprt := TSyncSaleLocalReprt.Create;
  Reg.RegisterFunctionItem(syncSaleLocalReprt);

  orgInvoinceDetailReprt := TOrgInvoinceDetailReprt.Create;
  Reg.RegisterFunctionItem(orgInvoinceDetailReprt);

  balanceUnitInvoinces := TBalanceUnitInvoinces.Create;
  Reg.RegisterFunctionItem(balanceUnitInvoinces);

  presellMonthRevenue:=TPresellMonthRevenue.Create;
  reg.RegisterFunctionItem(presellMonthRevenue);

  vehicleIncome:=TVehicleIncome.Create;
  reg.RegisterFunctionItem(vehicleIncome);

  dayIncomeReprt:=TdayIncomeReprt.Create;
  reg.RegisterFunctionItem(dayIncomeReprt);
{$IFDEF DEBUG}
{$ENDIF}
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
