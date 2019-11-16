unit AuditlogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses AuditlogPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
//var paramManager:TparamManager;
var logFind:TLogManager;

begin
  logFind:=TLogManager.Create;
  Reg.RegisterFunctionItem(logFind);

{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('系统管理\数据审计日志',logFind.key,nil);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
