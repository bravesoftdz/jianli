unit FinancialBalanceMonthRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FinancialBalanceMonthRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var financialMonthRpt:FinancialRptManager;
  par:TFunctionItemParameters;

begin
  financialMonthRpt:=FinancialRptManager.Create;
  Reg.RegisterFunctionItem(financialMonthRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务收支月平衡表',financialMonthRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
