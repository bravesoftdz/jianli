unit PlusScheduleExport;

{ ------------------------------------
  功能说明：PlusSchedule.bpl插件单元
  创建日期：2011.07.09
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses PlusSchedulePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  plusScheduleItemFunctionItem: TPlusScheduleItemFunctionItem;
begin
   //注册功能
  plusScheduleItemFunctionItem := TPlusScheduleItemFunctionItem.Create;
  Reg.RegisterFunctionItem(plusScheduleItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('调度管理\加班管理', plusScheduleItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
