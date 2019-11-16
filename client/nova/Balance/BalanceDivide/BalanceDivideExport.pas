unit BalanceDivideExport;
{ ------------------------------------
  功能说明：BalanceDivide.bpl插件单元
  创建日期：2012.08.24
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses BalanceDividePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  balancedivideFunctionItem: TBalanceDivideFunctionItem;
begin
   //注册功能
  balancedivideFunctionItem := TBalanceDivideFunctionItem.Create;
  Reg.RegisterFunctionItem(balancedivideFunctionItem);
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
