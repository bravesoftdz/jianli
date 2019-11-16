{------------------------------------
  功能说明：TicketSale.bpl输出单元
  创建日期：2011.1.26
  作者：ice
  版权：nova
-------------------------------------}
unit TicketSaleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketSalePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  ticketSale: TSellTicketFunction;
  parameters:TFunctionItemParameters;
  printticket:TPrintTicketFunction;
begin
  ticketSale := TSellTicketFunction.Create;
  Reg.RegisterFunctionItem(ticketSale);
  printticket:=TPrintTicketFunction.Create;
  Reg.RegisterFunctionItem(printticket);
{$IFDEF DEBUG}
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='0';        //售票
  (SysService as IMainForm).CreateMenu('售票管理\售票', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='1';        //补票
  (SysService as IMainForm).CreateMenu('售票管理\补票', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='2';        //特权补票
  (SysService as IMainForm).CreateMenu('售票管理\特权补票', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='8';        //订票
  (SysService as IMainForm).CreateMenu('售票管理\订票', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='1670';
  (SysService as IMainForm).CreateMenu('售票管理\测试重打车票', printticket.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='6';        //订票销售
  (SysService as IMainForm).CreateMenu('售票管理\订票销售', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='4';        //改签
  (SysService as IMainForm).CreateMenu('售票管理\改签', ticketSale.key, parameters);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
