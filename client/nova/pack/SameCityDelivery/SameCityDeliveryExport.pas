unit SameCityDeliveryExport;

{ ------------------------------------
  功能说明：SameCityDelivery.bpl输出单元
  创建日期：2011.06.03
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses SameCityDeliveryPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  SameCityDeliveryFunctionItem: TSameCityDeliveryFunctionItem;
begin
   //注册功能
  SameCityDeliveryFunctionItem := TSameCityDeliveryFunctionItem.Create;
  Reg.RegisterFunctionItem(SameCityDeliveryFunctionItem);

end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
