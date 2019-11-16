unit DriverExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DriverPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var driver:driverManager;
  par:TFunctionItemParameters;

begin
  driver:=driverManager.Create;
  Reg.RegisterFunctionItem(driver);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('��������\��ʻԱ��������',driver.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
