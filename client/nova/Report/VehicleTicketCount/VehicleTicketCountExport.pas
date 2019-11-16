unit VehicleTicketCountExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleTicketCountPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleTicketCount:VehicleTicketCountManager;
  par:TFunctionItemParameters;

begin
  vehicleTicketCount:=VehicleTicketCountManager.Create;
  Reg.RegisterFunctionItem(vehicleTicketCount);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('车辆售票流量统计',vehicleTicketCount.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
