unit CheckTicketExport;

{ ------------------------------------
  功能说明：CheckTicket.bpl输出单元
  创建日期：2011.05.17
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses CheckTicketPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  checkTicketItemFunctionItem: TCheckTicketItemFunctionItem;
begin
  // 注册功能
  checkTicketItemFunctionItem := TCheckTicketItemFunctionItem.Create;
  Reg.RegisterFunctionItem(checkTicketItemFunctionItem);
 // checkBillItemFunctionItem := TCheckBillItemFunctionItem.Create;
 // Reg.RegisterFunctionItem(checkBillItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('检票管理\综合检票', checkTicketItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
