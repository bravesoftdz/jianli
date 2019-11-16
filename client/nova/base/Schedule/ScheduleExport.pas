unit ScheduleExport;

{ ------------------------------------
  功能说明：schedule.bpl输出单元
  创建日期：2011.01.28
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses SchedulePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  scheduleFunctionItem: TScheduleFunctionItem;
begin
   //注册功能
  scheduleFunctionItem := TScheduleFunctionItem.Create;
  Reg.RegisterFunctionItem(scheduleFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('业务管理\班次管理', scheduleFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
