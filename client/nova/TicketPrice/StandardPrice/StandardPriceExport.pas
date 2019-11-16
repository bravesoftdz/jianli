unit StandardPriceExport;

{ ------------------------------------
  功能说明：StandardPrice.bpl输出单元
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
uses StandardPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  standardPriceFunctionItem: TStandardPriceFunctionItem;
begin
   //注册功能
  standardPriceFunctionItem := TStandardPriceFunctionItem.Create;
  Reg.RegisterFunctionItem(standardPriceFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\公式票价', standardPriceFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
