unit BilldestroyExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses BilldestroyPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  billdestroyPlugin: TBilldestroyPlugin;
  par: TFunctionItemParameters;

begin
  billdestroyPlugin := TBilldestroyPlugin.Create;
  Reg.RegisterFunctionItem(billdestroyPlugin);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
