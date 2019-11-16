unit ExecutePriceExport;
{ ------------------------------------
  功能说明：ExecutePrice.bpl输出单元
  创建日期：2011.03.16
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses ExecutePricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  executePriceItemFunctionItem: TExecutePriceItemFunctionItem;
begin
   //注册功能
  executePriceItemFunctionItem := TExecutePriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(executePriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\营运计划管理', executePriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
