unit QueryRunSituationExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRunSituationPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
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
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\����վ�����Ӫ���',scheduleRunSituation.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
