unit QuerySchedulemergeExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySchedulemergePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querySchedulemerge:querySchedulemergeManager;
  par:TFunctionItemParameters;

begin
  querySchedulemerge:=querySchedulemergeManager.Create;
  Reg.RegisterFunctionItem(querySchedulemerge);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\并班情况查询',querySchedulemerge.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
