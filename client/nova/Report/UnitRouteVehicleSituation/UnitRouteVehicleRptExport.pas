unit UnitRouteVehicleRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses UnitRouteVehicleRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var rpt:unitRouteVehicleRptManager;
  par:TFunctionItemParameters;

begin
  rpt:=unitRouteVehicleRptManager.Create;
  Reg.RegisterFunctionItem(rpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('发班运量统计表',rpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
