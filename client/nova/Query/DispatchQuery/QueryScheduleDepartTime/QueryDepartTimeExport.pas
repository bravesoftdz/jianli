unit QueryDepartTimeExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDepartTimePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var scheduleDepart:scheduleDepartTimeManager;
  par:TFunctionItemParameters;

begin
  scheduleDepart:=scheduleDepartTimeManager.Create;
  Reg.RegisterFunctionItem(scheduleDepart);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\客运班线发车时刻表',scheduleDepart.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
