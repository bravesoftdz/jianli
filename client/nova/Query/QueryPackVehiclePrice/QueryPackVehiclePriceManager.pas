unit QueryPackVehiclePriceManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackVehiclePricePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryPackVehiclePriceItem: TQueryPackVehiclePriceItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackVehiclePriceItem:=TQueryPackVehiclePriceItem.Create;
  Reg.RegisterFunctionItem(QueryPackVehiclePriceItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\行包查询\车辆返款查询',QueryPackVehiclePriceItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
