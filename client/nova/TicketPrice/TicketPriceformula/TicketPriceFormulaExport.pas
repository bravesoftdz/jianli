unit TicketPriceFormulaExport;
{ ------------------------------------
  功能说明：TicketPriceFormula.bpl输出单元
  创建日期：2011.03.12
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses TicketPriceFormulaPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  ticketPriceFormulaItemFunctionItem: TTicketPriceFormulaItemFunctionItem;
begin
   //注册功能
  ticketPriceFormulaItemFunctionItem := TTicketPriceFormulaItemFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketPriceFormulaItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\票价公式管理', ticketPriceFormulaItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
