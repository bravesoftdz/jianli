unit ContractorExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ContractorPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var driver:constructorManager;
  par:TFunctionItemParameters;

begin
  driver:=constructorManager.Create;
  Reg.RegisterFunctionItem(driver);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\�а��ߵ�������',driver.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
