unit SetDriverVehicleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  SetDriverVehiclePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  SetDriverVehicleFunction :TSetDriverVehicleFunction;
  parameters:TFunctionItemParameters;
begin
  SetDriverVehicleFunction := TSetDriverVehicleFunction.Create;
  Reg.RegisterFunctionItem(SetDriverVehicleFunction);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
