unit PublicQryExport;

{ ------------------------------------
  功能说明：ExplorerTest.bpl输出单元
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
uses PublicQryPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  ExplorerTestFunctionItem: TPublicQryFunctionItem;
begin
   //注册功能
  ExplorerTestFunctionItem := TPublicQryFunctionItem.Create;
  Reg.RegisterFunctionItem(ExplorerTestFunctionItem);

end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
