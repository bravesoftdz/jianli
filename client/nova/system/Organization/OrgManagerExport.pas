unit OrgManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses OrgManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var orgManagerExport:TOrgManagerExport;
begin
  orgManagerExport:=TOrgManagerExport.Create;
  Reg.RegisterFunctionItem(orgManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ϵͳ����\��֯����',orgManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
