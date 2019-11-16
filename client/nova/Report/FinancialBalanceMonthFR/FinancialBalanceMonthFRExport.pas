unit FinancialBalanceMonthFRExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FinancialBalanceMonthFRPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var financialMonthFR:FinancialFRManager;
  par:TFunctionItemParameters;

begin
  financialMonthFR:=FinancialFRManager.Create;
  Reg.RegisterFunctionItem(financialMonthFR);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�����¶���֧ƽ���',financialMonthFR.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
