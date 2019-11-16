unit ScheduleOperationReportExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleOperationReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var scheduleOperation:scheduleOperationManager;
  par:TFunctionItemParameters;

begin
  scheduleOperation:=scheduleOperationManager.Create;
  Reg.RegisterFunctionItem(scheduleOperation);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('������Ӫ������ܱ�',scheduleOperation.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
