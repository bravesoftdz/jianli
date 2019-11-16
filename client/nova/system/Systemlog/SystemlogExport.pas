unit SystemlogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses SystemlogPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
//var paramManager:TparamManager;
var logFind:TLogManager;

begin
  logFind:=TLogManager.Create;
  Reg.RegisterFunctionItem(logFind);

{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('系统管理\错误日志查询',logFind.key,nil);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
