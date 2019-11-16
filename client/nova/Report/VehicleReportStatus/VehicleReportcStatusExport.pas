unit VehicleReportcStatusExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleReportStatusPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleReportStatus:vehicleReportStatusManager;
  par:TFunctionItemParameters;

begin
  vehicleReportStatus:=vehicleReportStatusManager.Create;
  Reg.RegisterFunctionItem(vehicleReportStatus);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('车辆报班情况一览表',vehicleReportStatus.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
