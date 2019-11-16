unit SchedulemergeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SchedulemergeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var schedulemergeManagerExport: TSchedulemergeManagerExport;
begin
  schedulemergeManagerExport:=TSchedulemergeManagerExport.Create;
  Reg.RegisterFunctionItem(schedulemergeManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('���ȹ���\��β���',schedulemergeManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
