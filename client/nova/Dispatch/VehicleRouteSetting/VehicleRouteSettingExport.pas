unit VehicleRouteSettingExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicleRouteSettingPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var FrmVehicleRouteSettingItem: TFrmVehicleRouteSettingItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmVehicleRouteSettingItem:=TFrmVehicleRouteSettingItem.Create;
  Reg.RegisterFunctionItem(FrmVehicleRouteSettingItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('生产调度\调度管理\车辆运营线路设置',FrmVehicleRouteSettingItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
