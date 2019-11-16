unit ScheduleStationDepartinvoiceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses ScheduleStationDepartinvoiceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var scheduleStationDepartinvoiceManagerExport: TScheduleStationDepartinvoiceManagerExport;
begin
  scheduleStationDepartinvoiceManagerExport:=TScheduleStationDepartinvoiceManagerExport.Create;
  Reg.RegisterFunctionItem(scheduleStationDepartinvoiceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\班线停靠站点运量情况汇总表',scheduleStationDepartinvoiceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
