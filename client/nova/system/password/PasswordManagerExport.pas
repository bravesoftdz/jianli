unit PasswordManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PasswordManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var passwordManagerExport:TPasswordManagerExport;
    test_parm: TFunctionItemParameters;
begin
  passwordManagerExport:=TPasswordManagerExport.Create;
  Reg.RegisterFunctionItem(passwordManagerExport);
{$IFDEF DEBUG}
  test_parm := TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('系统管理\修改密码',passwordManagerExport.key,test_parm);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
