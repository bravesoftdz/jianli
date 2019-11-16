unit FinancialBalanceMonthRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FinancialBalanceMonthRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var financialMonthRpt:FinancialRptManager;
  par:TFunctionItemParameters;

begin
  financialMonthRpt:=FinancialRptManager.Create;
  Reg.RegisterFunctionItem(financialMonthRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('������֧��ƽ���',financialMonthRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
