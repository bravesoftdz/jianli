unit QueryVehicleLostExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleLostPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryVehicleLost:queryVehicleLostManager;
  par:TFunctionItemParameters;

begin
  queryVehicleLost:=queryVehicleLostManager.Create;
  Reg.RegisterFunctionItem(queryVehicleLost);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\脱班班次情况查询',queryVehicleLost.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
