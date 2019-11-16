unit FinancialBalanceRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FinancialBalanceRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var financialBalanceRpt:FinancialBalanceRptManager;
  par:TFunctionItemParameters;

begin
  financialBalanceRpt:=FinancialBalanceRptManager.Create;
  Reg.RegisterFunctionItem(financialBalanceRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务收支月平衡表',financialBalanceRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
