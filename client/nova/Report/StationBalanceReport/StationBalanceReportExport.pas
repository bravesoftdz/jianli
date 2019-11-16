unit StationBalanceReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses StationBalanceReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  stationBalanceReportManager: TStationBalanceReportManager;
  routeSaleReportManager:TRouteSaleReportManager;
  par: TFunctionItemParameters;
  ScheduleBalancePrice: TScheduleBalancePriceManager;
  RouteBalancePriceManager:TRouteBalancePriceManager;
  QryRouteIncomesManager:TQryRouteIncomesManager;
begin
  stationBalanceReportManager := TStationBalanceReportManager.Create;
  Reg.RegisterFunctionItem(stationBalanceReportManager);
   routeSaleReportManager := TRouteSaleReportManager.Create;
  Reg.RegisterFunctionItem(routeSaleReportManager);

   ScheduleBalancePrice := TScheduleBalancePriceManager.Create;
  Reg.RegisterFunctionItem(ScheduleBalancePrice);

    RouteBalancePriceManager := TRouteBalancePriceManager.Create;
  Reg.RegisterFunctionItem(RouteBalancePriceManager);


    QryRouteIncomesManager := TQryRouteIncomesManager.Create;
  Reg.RegisterFunctionItem(QryRouteIncomesManager);
{$IFDEF DEBUG}
  par := TFunctionItemParameters.Create; (SysService as IMainForm)
  .CreateMenu('报表统计\财务报表', stationBalanceReportManager.key, par);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
