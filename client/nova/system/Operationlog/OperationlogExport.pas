unit OperationlogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses OperationlogPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
//var paramManager:TparamManager;
var Operationlog:TOperationManager;

begin
  Operationlog:=TOperationManager.Create;
  Reg.RegisterFunctionItem(Operationlog);

{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('系统管理\操作日志查询',Operationlog.key,nil);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
