unit QryFinancialBalanceGZExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QryFinancialBalanceGZPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var GZReport:GZManager;
  par:TFunctionItemParameters;

begin
  GZReport:=GZManager.Create;
  Reg.RegisterFunctionItem(GZReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务报表\客运收入支出平衡表-赣州',
            GZReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
