unit QueryVehicleReportExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryVehicleReport:queryVehicleReportManager;
  par:TFunctionItemParameters;

begin
  queryVehicleReport:=queryVehicleReportManager.Create;
  Reg.RegisterFunctionItem(queryVehicleReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('检票查询\班次报班情况查询',queryVehicleReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
