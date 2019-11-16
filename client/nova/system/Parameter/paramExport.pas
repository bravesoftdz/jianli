unit paramExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses paramPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
//var paramManager:TparamManager;
var parameter:TparamManager;
  par:TFunctionItemParameters;

begin
  parameter:=TparamManager.Create;
  Reg.RegisterFunctionItem(parameter);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('系统管理\参数设置',parameter.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
