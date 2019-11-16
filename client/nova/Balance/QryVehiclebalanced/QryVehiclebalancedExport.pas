unit QryVehiclebalancedExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses QryVehiclebalancedPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  balanceFunctionItem: TVehicleBalanceFunctionItem;
begin
  // ע�Ṧ��
  balanceFunctionItem := TVehicleBalanceFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
