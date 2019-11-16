unit VehicleStationDepartinvoiceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicleStationDepartinvoiceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleStationDepartinvoiceManagerExport: TVehicleStationDepartinvoiceManagerExport;
begin
  vehicleStationDepartinvoiceManagerExport:=TVehicleStationDepartinvoiceManagerExport.Create;
  Reg.RegisterFunctionItem(vehicleStationDepartinvoiceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\车辆停靠站点运量情况汇总表',vehicleStationDepartinvoiceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
