unit ScheduleManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses ScheduleManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var scheduleManagerExport: TScheduleManagerExport;
begin
  scheduleManagerExport:=TScheduleManagerExport.Create;
  Reg.RegisterFunctionItem(scheduleManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\��α�����',scheduleManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
