unit TicketoutletsPriceExport;
{ ------------------------------------
  功能说明：TicketoutletsPrice.bpl输出单元
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
uses TicketoutletsPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  ticketPriceItemFunctionItem: TTicketPriceItemFunctionItem;
begin
   //注册功能
  ticketPriceItemFunctionItem := TTicketPriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketPriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('售票点票价差额管理', ticketPriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
