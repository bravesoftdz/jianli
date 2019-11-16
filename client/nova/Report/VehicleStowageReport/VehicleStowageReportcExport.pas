unit VehicleStowageReportcExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleStowageReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleStowageReport:vehicleStowageReportManager;
  par:TFunctionItemParameters;

begin
  vehicleStowageReport:=vehicleStowageReportManager.Create;
  Reg.RegisterFunctionItem(vehicleStowageReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('车辆营运配载统计表',vehicleStowageReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
