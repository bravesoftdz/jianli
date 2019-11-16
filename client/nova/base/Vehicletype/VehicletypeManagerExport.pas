unit VehicletypeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicletypeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicletypeManagerExport:TVehicletypeManagerExport;
begin
  vehicletypeManagerExport:=TVehicletypeManagerExport.Create;
  Reg.RegisterFunctionItem(vehicletypeManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\���͹���',vehicletypeManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
