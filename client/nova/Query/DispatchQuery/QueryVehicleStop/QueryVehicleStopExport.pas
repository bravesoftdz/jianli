unit QueryVehicleStopExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleStopPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryVehicleStop:queryVehicleStopManager;
  par:TFunctionItemParameters;

begin
  queryVehicleStop:=queryVehicleStopManager.Create;
  Reg.RegisterFunctionItem(queryVehicleStop);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\ͣ���������ѯ',queryVehicleStop.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
