unit RouteBalanceRptExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses RouteBalanceRptPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  routeBalanceRptExport: TRouteBalanceRptExport;
  test_parm: TFunctionItemParameters;
begin
  routeBalanceRptExport := TRouteBalanceRptExport.Create;
  Reg.RegisterFunctionItem(routeBalanceRptExport);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.



