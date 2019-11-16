unit DriverExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DriverPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var driver:driverManager;
  par:TFunctionItemParameters;

begin
  driver:=driverManager.Create;
  Reg.RegisterFunctionItem(driver);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('档案管理\驾驶员档案管理',driver.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
