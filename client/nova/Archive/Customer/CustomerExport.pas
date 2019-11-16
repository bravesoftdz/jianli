unit CustomerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件

procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses CustomerPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var Customer:CustomerManager;
  par:TFunctionItemParameters;

begin
  Customer:=CustomerManager.Create;
  Reg.RegisterFunctionItem(Customer);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('档案管理\顾客档案管理',Customer.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
