unit VehicleturnoverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicleturnoverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleturnoverManagerExport: TVehicleturnoverManagerExport;
begin
  vehicleturnoverManagerExport:=TVehicleturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(vehicleturnoverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\�����ɿ�',vehicleturnoverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
