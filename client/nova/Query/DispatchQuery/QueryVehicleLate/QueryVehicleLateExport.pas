unit QueryVehicleLateExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleLatePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryVehicleLate:queryVehicleLateManager;
  par:TFunctionItemParameters;

begin
  queryVehicleLate:=queryVehicleLateManager.Create;
  Reg.RegisterFunctionItem(queryVehicleLate);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\����������ѯ',queryVehicleLate.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
