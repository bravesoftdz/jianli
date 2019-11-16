unit QueryRouteDynamicExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRouteDynamicPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querysrouteDynamic:routeDynamicManager;
  par:TFunctionItemParameters;

begin
  querysrouteDynamic:=routeDynamicManager.Create;
  Reg.RegisterFunctionItem(querysrouteDynamic);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('客运班线动态表',querysrouteDynamic.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
