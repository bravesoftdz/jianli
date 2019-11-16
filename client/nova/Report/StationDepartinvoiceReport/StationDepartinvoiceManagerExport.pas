unit StationDepartinvoiceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationDepartinvoiceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var stationDepartinvoiceManagerExport: TStationDepartinvoiceManagerExport;
begin
  stationDepartinvoiceManagerExport:=TStationDepartinvoiceManagerExport.Create;
  Reg.RegisterFunctionItem(stationDepartinvoiceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\停靠站点运量情况汇总表',stationDepartinvoiceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
