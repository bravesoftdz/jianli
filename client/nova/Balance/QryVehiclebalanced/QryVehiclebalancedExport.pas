unit QryVehiclebalancedExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses QryVehiclebalancedPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  balanceFunctionItem: TVehicleBalanceFunctionItem;
begin
  // ×¢²á¹¦ÄÜ
  balanceFunctionItem := TVehicleBalanceFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceFunctionItem);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
