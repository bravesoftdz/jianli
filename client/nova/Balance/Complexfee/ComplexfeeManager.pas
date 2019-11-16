unit ComplexfeeManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses ComplexfeePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ComplexfeeMg:ComplexfeeMS;
begin
  ComplexfeeMg:= ComplexfeeMS.Create;
  Reg.RegisterFunctionItem(ComplexfeeMg);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\�ۺ��շ���Ϣ����',ComplexfeeMg.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
