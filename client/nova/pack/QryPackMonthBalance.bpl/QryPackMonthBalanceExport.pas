unit QryPackMonthBalanceExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses QryPackMonthBalancePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  PackMonthBalanceItem:TPackMonthBalanceItem;
begin
   //注册功能
  PackMonthBalanceItem := TPackMonthBalanceItem.Create;
  Reg.RegisterFunctionItem(PackMonthBalanceItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('行包管理\货物月结算表', PackMonthBalanceItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
