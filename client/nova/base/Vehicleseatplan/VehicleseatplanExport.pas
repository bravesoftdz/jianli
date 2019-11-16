{------------------------------------
  功能说明：Vehicleseatplan.bpl输出单元
  创建日期：2011.2.22
  作者：ice
  版权：nova
-------------------------------------}
unit VehicleseatplanExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses VehicleseatplanPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  vehiclespaceManager: TVehiclespaceManager;
  vehicleseatplanManager:TVehicleseatplanManager;
begin
  vehiclespaceManager := TVehiclespaceManager.Create;
  Reg.RegisterFunctionItem(vehiclespaceManager);
  vehicleseatplanManager:=TvehicleseatplanManager.Create;
  Reg.RegisterFunctionItem(vehicleseatplanManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('业务管理\车辆内部空间管理', vehiclespaceManager.key, nil);
    (SysService as IMainForm).CreateMenu('业务管理\车辆座位图管理', vehicleseatplanManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
