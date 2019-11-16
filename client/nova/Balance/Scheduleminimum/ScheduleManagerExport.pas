unit ScheduleManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses ScheduleManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var scheduleManagerExport: TScheduleManagerExport;
begin
  scheduleManagerExport:=TScheduleManagerExport.Create;
  Reg.RegisterFunctionItem(scheduleManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\班次保低数',scheduleManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
