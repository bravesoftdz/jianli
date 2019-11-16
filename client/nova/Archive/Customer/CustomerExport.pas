unit CustomerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����

procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses CustomerPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var Customer:CustomerManager;
  par:TFunctionItemParameters;

begin
  Customer:=CustomerManager.Create;
  Reg.RegisterFunctionItem(Customer);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\�˿͵�������',Customer.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
