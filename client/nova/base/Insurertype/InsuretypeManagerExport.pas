unit InsuretypeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsuretypeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var insuretypeManagerExport:TInsuretypeManagerExport;
begin
  insuretypeManagerExport:=TInsuretypeManagerExport.Create;
  Reg.RegisterFunctionItem(insuretypeManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\��������',insuretypeManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
