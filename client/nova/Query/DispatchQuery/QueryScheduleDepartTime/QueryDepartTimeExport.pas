unit QueryDepartTimeExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDepartTimePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var scheduleDepart:scheduleDepartTimeManager;
  par:TFunctionItemParameters;

begin
  scheduleDepart:=scheduleDepartTimeManager.Create;
  Reg.RegisterFunctionItem(scheduleDepart);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\���˰��߷���ʱ�̱�',scheduleDepart.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
