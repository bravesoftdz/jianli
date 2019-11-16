unit FinancialBalanceRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FinancialBalanceRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var financialBalanceRpt:FinancialBalanceRptManager;
  par:TFunctionItemParameters;

begin
  financialBalanceRpt:=FinancialBalanceRptManager.Create;
  Reg.RegisterFunctionItem(financialBalanceRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('������֧��ƽ���',financialBalanceRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
