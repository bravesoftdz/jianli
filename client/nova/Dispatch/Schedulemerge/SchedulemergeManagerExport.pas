unit SchedulemergeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses SchedulemergeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var schedulemergeManagerExport: TSchedulemergeManagerExport;
begin
  schedulemergeManagerExport:=TSchedulemergeManagerExport.Create;
  Reg.RegisterFunctionItem(schedulemergeManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('调度管理\班次并班',schedulemergeManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
