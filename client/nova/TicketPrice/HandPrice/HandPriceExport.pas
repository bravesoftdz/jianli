unit HandPriceExport;
{ ------------------------------------
  功能说明：HandPrice.bpl输出单元
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
uses HandPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  ticketPriceItemFunctionItem: TTicketPriceItemFunctionItem;
begin
   //注册功能
  ticketPriceItemFunctionItem := TTicketPriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketPriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\硬调票价管理', ticketPriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
