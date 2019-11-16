unit FuelfeegradeExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses FuelfeegradePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  fuelfeegradeFunctionItem: TFuelfeegradeFunctionItem;
begin
  // ע�Ṧ��
  fuelfeegradeFunctionItem := TFuelfeegradeFunctionItem.Create;
  Reg.RegisterFunctionItem(fuelfeegradeFunctionItem);
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
