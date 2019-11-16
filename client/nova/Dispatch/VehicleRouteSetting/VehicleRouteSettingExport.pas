unit VehicleRouteSettingExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicleRouteSettingPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var FrmVehicleRouteSettingItem: TFrmVehicleRouteSettingItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmVehicleRouteSettingItem:=TFrmVehicleRouteSettingItem.Create;
  Reg.RegisterFunctionItem(FrmVehicleRouteSettingItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('��������\���ȹ���\������Ӫ��·����',FrmVehicleRouteSettingItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
