unit ScheduleplanlogExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses ScheduleplanlogPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
// var paramManager:TparamManager;
var scheduleplanlog: TScheduleplanlogPlugin;

begin
  scheduleplanlog := TScheduleplanlogPlugin.Create;
  Reg.RegisterFunctionItem(scheduleplanlog);

  {$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('系统管理\班次计划日志查询',scheduleplanlog.key,nil);
  {$ENDIF}

end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
