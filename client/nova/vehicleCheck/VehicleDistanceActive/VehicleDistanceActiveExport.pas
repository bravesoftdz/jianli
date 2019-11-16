unit VehicleDistanceActiveExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleDistanceActivePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var DistanceActive:ActiveManager;
 par:TFunctionItemParameters;

begin
  DistanceActive:=ActiveManager.Create;
  Reg.RegisterFunctionItem(DistanceActive);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('安检管理\车辆行驶里程限制',DistanceActive.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
