unit QueryOverTimeScheduleExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryOverTimeSchedulePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var overTimeSchedule:OverTimeScheduleManager;
  par:TFunctionItemParameters;

begin
  overTimeSchedule:=OverTimeScheduleManager.Create;
  Reg.RegisterFunctionItem(overTimeSchedule);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\客运站加班次情况查询',overTimeSchedule.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
