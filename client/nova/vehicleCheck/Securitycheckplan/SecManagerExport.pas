unit SecManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SecManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var secManagerExport:TSecManagerExport;
begin
  secManagerExport:=TSecManagerExport.Create;
  Reg.RegisterFunctionItem(secManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\����ƻ�',secManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
