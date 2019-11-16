unit QueryVehicleStopExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleStopPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryVehicleStop:queryVehicleStopManager;
  par:TFunctionItemParameters;

begin
  queryVehicleStop:=queryVehicleStopManager.Create;
  Reg.RegisterFunctionItem(queryVehicleStop);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\停班班次情况查询',queryVehicleStop.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
