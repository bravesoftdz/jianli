unit StationUnitBalanceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationUnitBalanceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var StationUnitBalanceManagerExport: TStationUnitBalanceManagerPlugin;
begin
  StationUnitBalanceManagerExport:=TStationUnitBalanceManagerPlugin.Create;
  Reg.RegisterFunctionItem(StationUnitBalanceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('车站各经营单位核算表',StationUnitBalanceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
