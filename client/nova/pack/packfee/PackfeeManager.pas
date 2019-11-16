unit PackfeeManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackfeePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var packfeeItem: TPackfeeItem;
//   roleListItem:TRoleFunctionItem;
begin
 packfeeItem:=TPackfeeItem.Create;
  Reg.RegisterFunctionItem(packfeeItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\收费标准设置',packfeeItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
