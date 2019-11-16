unit BalanceformulaApplyExport;


{ ------------------------------------
  功能说明：BalanceformulaApply.bpl输出单元
  创建日期：2011.06.11
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses BalanceformulaApplyPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  balanceformulaApplyPlugin: TBalanceformulaApplyFunctionItem;
begin
   //注册功能
  balanceformulaApplyPlugin := TBalanceformulaApplyFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceformulaApplyPlugin);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('结算管理\结算扣费公式应用', balanceformulaApplyPlugin.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
