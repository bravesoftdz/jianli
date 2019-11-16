unit QuerySellBalanceSummaryExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����

procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySellBalanceSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var SellBalance:SellBalanceManager;
  par:TFunctionItemParameters;

begin
  SellBalance:=SellBalanceManager.Create;
  Reg.RegisterFunctionItem(SellBalance);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('����\��Ʊ�������ܱ�',SellBalance.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
