unit RouteChecktimeExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses RouteChecktimePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
// var paramManager:TparamManager;
var
  RouteChecktimePlugin: TRouteChecktimePlugin;

begin
  RouteChecktimePlugin := TRouteChecktimePlugin.Create;
  Reg.RegisterFunctionItem(RouteChecktimePlugin);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
