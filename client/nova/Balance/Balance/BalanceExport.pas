unit BalanceExport;


{ ------------------------------------
  功能说明：Balance.bpl输出单元
  创建日期：2011.06.22
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses BalancePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  balanceFunctionItem: TBalanceFunctionItem;
  packbalance: TPackBalance;
  packarrive: TPackArrive;
begin
   //注册功能
  balanceFunctionItem := TBalanceFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceFunctionItem);
  packbalance := TPackBalance.Create;
  Reg.RegisterFunctionItem(packbalance);
  packarrive := TPackArrive.Create;
  Reg.RegisterFunctionItem(packarrive);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('结算管理\结算单结算', balanceFunctionItem.key, nil);
(SysService as IMainForm)
  .CreateMenu('行包管理\出库结算', packarrive.key, nil);
(SysService as IMainForm)
  .CreateMenu('行包管理\前台结算', packbalance.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
