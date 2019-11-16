unit SecuritycheckitemManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SecuritycheckitemManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var securitycheckitemManagerExport:TSecuritycheckitemManagerExport;
begin
  securitycheckitemManagerExport:=TSecuritycheckitemManagerExport.Create;
  Reg.RegisterFunctionItem(securitycheckitemManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\����������Ŀ',securitycheckitemManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
