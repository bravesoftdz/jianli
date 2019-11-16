unit PackStockManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackStockPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var packStockItem: TpackStockItem;
//   roleListItem:TRoleFunctionItem;
begin
 packStockItem:=TpackStockItem.Create;
  Reg.RegisterFunctionItem(packStockItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\行包库存',packStockItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
