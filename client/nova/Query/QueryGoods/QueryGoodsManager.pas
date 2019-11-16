unit QueryGoodsManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryGoodsPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryGoodsItem: TQueryGoodsItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryGoodsItem:=TQueryGoodsItem.Create;
  Reg.RegisterFunctionItem(QueryGoodsItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\行包查询\小件营收统计',QueryGoodsItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.

