unit PackGoodsManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackGoodsPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var PackGoodsItem: TPackGoodsItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackGoodsItem:=TPackGoodsItem.Create;
  Reg.RegisterFunctionItem(PackGoodsItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\小件寄存',PackGoodsItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
