unit PasswordManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PasswordManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var passwordManagerExport:TPasswordManagerExport;
    test_parm: TFunctionItemParameters;
begin
  passwordManagerExport:=TPasswordManagerExport.Create;
  Reg.RegisterFunctionItem(passwordManagerExport);
{$IFDEF DEBUG}
  test_parm := TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ϵͳ����\�޸�����',passwordManagerExport.key,test_parm);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
