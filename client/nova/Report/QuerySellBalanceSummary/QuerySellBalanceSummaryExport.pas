unit QuerySellBalanceSummaryExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件

procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySellBalanceSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var SellBalance:SellBalanceManager;
  par:TFunctionItemParameters;

begin
  SellBalance:=SellBalanceManager.Create;
  Reg.RegisterFunctionItem(SellBalance);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('报表\售票点结算汇总表',SellBalance.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
