unit QueryPackShipmentManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackShipmentPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryPackShipmentItem: TQueryPackShipmentItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackShipmentItem:=TQueryPackShipmentItem.Create;
  Reg.RegisterFunctionItem(QueryPackShipmentItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\行包查询\行包发货营收统计',QueryPackShipmentItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
