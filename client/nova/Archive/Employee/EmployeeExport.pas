unit EmployeeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses EmployeePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var employee:employeeManager;
  par:TFunctionItemParameters;

begin
  employee:=employeeManager.Create;
  Reg.RegisterFunctionItem(employee);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('档案管理\员工档案管理',employee.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
