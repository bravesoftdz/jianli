unit TicketReturnRateCfgManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketReturnRateCfgPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var TicketReturnRateCfgManager:TTicketReturnRateCfgManager;
begin
  TicketReturnRateCfgManager:=TTicketReturnRateCfgManager.Create;
  Reg.RegisterFunctionItem(TicketReturnRateCfgManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\退票手续费率设置',TicketReturnRateCfgManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
