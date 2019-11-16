unit ContractorExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ContractorPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var driver:constructorManager;
  par:TFunctionItemParameters;

begin
  driver:=constructorManager.Create;
  Reg.RegisterFunctionItem(driver);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('档案管理\承包者档案管理',driver.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
