unit QueryBalancedExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryBalancedPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
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
  (SysService as  IMainForm).CreateMenu('结算管理\已结算查询',queryBalanced.key,par);
  (SysService as  IMainForm).CreateMenu('行包管理\行包已结账查询',packqryBalance.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
