unit QueryRunSituationExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRunSituationPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var
   scheduleRunSituation:scheduleRunSituationManager;
   par:TFunctionItemParameters;
   dayscheduleIncomeManager:tdayscheduleIncomeManager;
begin
  scheduleRunSituation:=scheduleRunSituationManager.Create;
  Reg.RegisterFunctionItem(scheduleRunSituation);


  dayscheduleIncomeManager:=TdayscheduleIncomeManager.Create;
  Reg.RegisterFunctionItem(dayscheduleIncomeManager);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\客运站班次运营情况',scheduleRunSituation.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
