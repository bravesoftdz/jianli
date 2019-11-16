unit ScheduleplanlogExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses ScheduleplanlogPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
// var paramManager:TparamManager;
var scheduleplanlog: TScheduleplanlogPlugin;

begin
  scheduleplanlog := TScheduleplanlogPlugin.Create;
  Reg.RegisterFunctionItem(scheduleplanlog);

  {$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ϵͳ����\��μƻ���־��ѯ',scheduleplanlog.key,nil);
  {$ENDIF}

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
