unit QueryPackVehiclePriceManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackVehiclePricePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryPackVehiclePriceItem: TQueryPackVehiclePriceItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackVehiclePriceItem:=TQueryPackVehiclePriceItem.Create;
  Reg.RegisterFunctionItem(QueryPackVehiclePriceItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�а���ѯ\���������ѯ',QueryPackVehiclePriceItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
