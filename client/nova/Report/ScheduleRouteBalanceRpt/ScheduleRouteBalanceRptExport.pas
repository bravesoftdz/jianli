unit ScheduleRouteBalanceRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleRouteBalanceRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var scheduleRouteBalanceRpt:scheduleRouteBalanceRptManager;
  par:TFunctionItemParameters;

begin
  scheduleRouteBalanceRpt:=scheduleRouteBalanceRptManager.Create;
  Reg.RegisterFunctionItem(scheduleRouteBalanceRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���߽���ͳ�Ʊ�',scheduleRouteBalanceRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
