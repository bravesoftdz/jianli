unit HolidayExport;
{ ------------------------------------
  功能说明：Holiday.bpl输出单元
  创建日期：2011.04.27
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses HolidayPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  holidayItemFunctionItem: THolidayItemFunctionItem;
begin
   //注册功能
  holidayItemFunctionItem := THolidayItemFunctionItem.Create;
  Reg.RegisterFunctionItem(holidayItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\节日信息', holidayItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
