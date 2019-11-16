unit DepartManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses DepartManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var
  departinvoicesManagerExport:TDepartinvoicesManagerExport;
  departinvoicesJcExport:TDepartinvoicesJcExport;
begin
  departinvoicesManagerExport:=TDepartinvoicesManagerExport.Create;
  Reg.RegisterFunctionItem(departinvoicesManagerExport);

  departinvoicesJcExport:=TDepartinvoicesJcExport.Create;
  Reg.RegisterFunctionItem(departinvoicesJcExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\���㵥����',departinvoicesManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
