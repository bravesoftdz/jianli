unit FuelfeegradeExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses FuelfeegradePlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  fuelfeegradeFunctionItem: TFuelfeegradeFunctionItem;
begin
  // ×¢²á¹¦ÄÜ
  fuelfeegradeFunctionItem := TFuelfeegradeFunctionItem.Create;
  Reg.RegisterFunctionItem(fuelfeegradeFunctionItem);
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
