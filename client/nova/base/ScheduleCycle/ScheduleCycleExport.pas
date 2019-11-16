unit ScheduleCycleExport;

{ ------------------------------------
  功能说明：schedulecycle.bpl输出单元
  创建日期：2011.03.03
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses ScheduleCyclePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  scheduleCycleFunctionItem: TScheduleCycleFunctionItem;
begin
   //注册功能
  scheduleCycleFunctionItem := TScheduleCycleFunctionItem.Create;
  Reg.RegisterFunctionItem(scheduleCycleFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('业务管理\班次循环管理', scheduleCycleFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
