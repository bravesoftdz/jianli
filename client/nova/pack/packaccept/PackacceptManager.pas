unit PackacceptManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackacceptPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var packacceptItem: TpackacceptItem;
//   roleListItem:TRoleFunctionItem;
begin
 packacceptItem:=TpackacceptItem.Create;
  Reg.RegisterFunctionItem(packacceptItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\到货入仓',packacceptItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
