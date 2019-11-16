unit ScheduleOperationReportExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleOperationReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var scheduleOperation:scheduleOperationManager;
  par:TFunctionItemParameters;

begin
  scheduleOperation:=scheduleOperationManager.Create;
  Reg.RegisterFunctionItem(scheduleOperation);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('班线运营情况汇总表',scheduleOperation.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
