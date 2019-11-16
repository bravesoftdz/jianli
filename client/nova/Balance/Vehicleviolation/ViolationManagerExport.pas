unit ViolationManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses ViolationManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var violationManagerExport:TViolationManagerExport;
begin
  violationManagerExport:=TViolationManagerExport.Create;
  Reg.RegisterFunctionItem(violationManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\Ӫ�˳���Υ�洦��',violationManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
