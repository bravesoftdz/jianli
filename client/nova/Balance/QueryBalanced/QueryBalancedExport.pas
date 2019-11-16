unit QueryBalancedExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryBalancedPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryBalanced:queryBalancedManager;
    packqryBalance:packqryBalanceManager;
  par:TFunctionItemParameters;

begin
  queryBalanced:=queryBalancedManager.Create;
  Reg.RegisterFunctionItem(queryBalanced);
  packqryBalance:=packqryBalanceManager.Create;
  Reg.RegisterFunctionItem(packqryBalance);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�������\�ѽ����ѯ',queryBalanced.key,par);
  (SysService as  IMainForm).CreateMenu('�а�����\�а��ѽ��˲�ѯ',packqryBalance.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
