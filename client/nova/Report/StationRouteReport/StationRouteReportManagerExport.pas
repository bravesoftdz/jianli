unit StationRouteReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationRouteReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var stationRManagerExport: TStationRouteReportManagerExport;
begin
  stationRManagerExport:=TStationRouteReportManagerExport.Create;
  Reg.RegisterFunctionItem(stationRManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\客运班线调查统计表',stationRManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
