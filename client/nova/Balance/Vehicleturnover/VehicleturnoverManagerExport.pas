unit VehicleturnoverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicleturnoverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleturnoverManagerExport: TVehicleturnoverManagerExport;
begin
  vehicleturnoverManagerExport:=TVehicleturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(vehicleturnoverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\车辆缴款',vehicleturnoverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
