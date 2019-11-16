unit RouteBalanceRptExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses RouteBalanceRptPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  routeBalanceRptExport: TRouteBalanceRptExport;
  test_parm: TFunctionItemParameters;
begin
  routeBalanceRptExport := TRouteBalanceRptExport.Create;
  Reg.RegisterFunctionItem(routeBalanceRptExport);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.



