unit PackWarehousingManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackWarehousingPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var PackWarehousingItem: TPackWarehousingItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackWarehousingItem:=TPackWarehousingItem.Create;
  Reg.RegisterFunctionItem(PackWarehousingItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\到货入仓',PackWarehousingItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
