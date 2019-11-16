unit ScheduleRouteBalanceRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleRouteBalanceRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var scheduleRouteBalanceRpt:scheduleRouteBalanceRptManager;
  par:TFunctionItemParameters;

begin
  scheduleRouteBalanceRpt:=scheduleRouteBalanceRptManager.Create;
  Reg.RegisterFunctionItem(scheduleRouteBalanceRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('班线结算统计表',scheduleRouteBalanceRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
