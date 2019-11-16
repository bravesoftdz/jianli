unit TickettypepermissionManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TickettypepermissionPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var tickettypepermissionManager:TTickettypepermissionManager;
begin
  tickettypepermissionManager:=TTickettypepermissionManager.Create;
  Reg.RegisterFunctionItem(tickettypepermissionManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\车票类型可售权限控制',tickettypepermissionManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
