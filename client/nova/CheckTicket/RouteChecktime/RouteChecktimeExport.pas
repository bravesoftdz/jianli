unit RouteChecktimeExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses RouteChecktimePlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
// var paramManager:TparamManager;
var
  RouteChecktimePlugin: TRouteChecktimePlugin;

begin
  RouteChecktimePlugin := TRouteChecktimePlugin.Create;
  Reg.RegisterFunctionItem(RouteChecktimePlugin);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
