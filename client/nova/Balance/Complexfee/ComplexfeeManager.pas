unit ComplexfeeManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses ComplexfeePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ComplexfeeMg:ComplexfeeMS;
begin
  ComplexfeeMg:= ComplexfeeMS.Create;
  Reg.RegisterFunctionItem(ComplexfeeMg);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\综合收费信息管理',ComplexfeeMg.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
