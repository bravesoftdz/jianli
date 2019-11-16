unit BalanceformulaExport;

{ ------------------------------------
  功能说明：Balanceformula.bpl输出单元
  创建日期：2011.06.08
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses BalanceformulaPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  balanceformulaFunctionItem: TBalanceformulaFunctionItem;
begin
   //注册功能
  balanceformulaFunctionItem := TBalanceformulaFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceformulaFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('结算管理\结算扣费公式设置', balanceformulaFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
