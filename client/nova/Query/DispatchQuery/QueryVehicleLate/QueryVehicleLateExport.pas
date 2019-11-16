unit QueryVehicleLateExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleLatePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryVehicleLate:queryVehicleLateManager;
  par:TFunctionItemParameters;

begin
  queryVehicleLate:=queryVehicleLateManager.Create;
  Reg.RegisterFunctionItem(queryVehicleLate);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\晚点班次情况查询',queryVehicleLate.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
