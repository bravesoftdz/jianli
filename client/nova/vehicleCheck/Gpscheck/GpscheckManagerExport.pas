unit GpscheckManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses GpscheckManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var gpscheckManagerExport:TGpscheckManagerExport;
begin
 gpscheckManagerExport:=TGpscheckManagerExport.Create;
  Reg.RegisterFunctionItem(gpscheckManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\���㵥��¼',gpscheckManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
