unit UpgradelogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses UpgradelogePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var upl:Upgradelog;
  par:TFunctionItemParameters;

begin
  upl:=upgradelog.Create;
  Reg.RegisterFunctionItem(upl);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('系统管理\系统升级日志',upl.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
