unit ScheduleStationDepartinvoiceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses ScheduleStationDepartinvoiceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var scheduleStationDepartinvoiceManagerExport: TScheduleStationDepartinvoiceManagerExport;
begin
  scheduleStationDepartinvoiceManagerExport:=TScheduleStationDepartinvoiceManagerExport.Create;
  Reg.RegisterFunctionItem(scheduleStationDepartinvoiceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\����ͣ��վ������������ܱ�',scheduleStationDepartinvoiceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
