unit DeductManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses DeductManagePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var deductManager:TDeductManager;
begin
  deductManager:=TDeductManager.Create;
  Reg.RegisterFunctionItem(deductManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\扣费管理',deductManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
