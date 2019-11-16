unit SalerdayReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses SalerdayReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
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

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
