unit EmployeeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses EmployeePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var employee:employeeManager;
  par:TFunctionItemParameters;

begin
  employee:=employeeManager.Create;
  Reg.RegisterFunctionItem(employee);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\Ա����������',employee.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
