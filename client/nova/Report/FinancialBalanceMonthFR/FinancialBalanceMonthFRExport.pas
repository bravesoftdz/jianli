unit FinancialBalanceMonthFRExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FinancialBalanceMonthFRPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var financialMonthFR:FinancialFRManager;
  par:TFunctionItemParameters;

begin
  financialMonthFR:=FinancialFRManager.Create;
  Reg.RegisterFunctionItem(financialMonthFR);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务月度收支平衡表',financialMonthFR.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
