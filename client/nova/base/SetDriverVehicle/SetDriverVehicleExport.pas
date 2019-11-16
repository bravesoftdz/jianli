unit SetDriverVehicleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  SetDriverVehiclePlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  SetDriverVehicleFunction :TSetDriverVehicleFunction;
  parameters:TFunctionItemParameters;
begin
  SetDriverVehicleFunction := TSetDriverVehicleFunction.Create;
  Reg.RegisterFunctionItem(SetDriverVehicleFunction);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
