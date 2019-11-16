unit DepartinvoicesSellerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DepartinvoicesSellerPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
//var paramManager:TparamManager;
var DSManager:TDSManager;
  par:TFunctionItemParameters;

begin
  DSManager:=TDSManager.Create;
  Reg.RegisterFunctionItem(DSManager);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务报表\售票员结算单',DSManager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
