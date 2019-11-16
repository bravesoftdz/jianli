unit TicketLossExport;

{ ------------------------------------
  功能说明：TicketLoss.bpl输出单元
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
uses TicketLossPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  TicketLossFunctionItem: TTicketLossFunctionItem;
begin
   //注册功能
  TicketLossFunctionItem := TTicketLossFunctionItem.Create;
  Reg.RegisterFunctionItem(TicketLossFunctionItem);

end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
