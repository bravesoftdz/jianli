unit RoutePriceExport;

{ ------------------------------------
  功能说明：RoutePrice.bpl输出单元
  创建日期：2014.12.18
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses RoutePricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  routePriceItemFunctionItem: TRoutePriceItemFunctionItem;
begin
   //注册功能
  routePriceItemFunctionItem := TRoutePriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(routePriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\线路票价信息', routePriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
