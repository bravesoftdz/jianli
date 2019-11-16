unit ScheduleSellDaysExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleSellDaysPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var ScheduleSellDays:ScheduleSellDaysMS;
  par:TFunctionItemParameters;

begin
  ScheduleSellDays:=ScheduleSellDaysMS.Create;
  Reg.RegisterFunctionItem(ScheduleSellDays);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\班次预售天数控制',ScheduleSellDays.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
