unit DepartinvoicesotherManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses DepartinvoicesotherManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var departinvoicesotherManagerExport:TDepartinvoicesotherManagerExport;

begin
  departinvoicesotherManagerExport:=TDepartinvoicesotherManagerExport.Create;
  Reg.RegisterFunctionItem(departinvoicesotherManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\���㵥��¼',departinvoicesotherManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
