unit VehicleDistanceActiveExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleDistanceActivePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var DistanceActive:ActiveManager;
 par:TFunctionItemParameters;

begin
  DistanceActive:=ActiveManager.Create;
  Reg.RegisterFunctionItem(DistanceActive);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�������\������ʻ�������',DistanceActive.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
