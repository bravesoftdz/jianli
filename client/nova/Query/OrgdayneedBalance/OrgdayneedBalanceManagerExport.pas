unit OrgdayneedBalanceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses OrgdayneedBalanceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var orgdayneedBalanceManagerExport: TOrgdayneedBalanceManagerExport;
begin
  orgdayneedBalanceManagerExport:=TOrgdayneedBalanceManagerExport.Create;
  Reg.RegisterFunctionItem(orgdayneedBalanceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\机构每日结算',orgdayneedBalanceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
