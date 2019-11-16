unit QueryOverTimeScheduleExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryOverTimeSchedulePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var overTimeSchedule:OverTimeScheduleManager;
  par:TFunctionItemParameters;

begin
  overTimeSchedule:=OverTimeScheduleManager.Create;
  Reg.RegisterFunctionItem(overTimeSchedule);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\����վ�Ӱ�������ѯ',overTimeSchedule.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
