unit PackdeliveryManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackdeliveryPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var packdeliveryItem: TPackdeliveryItem;
//   roleListItem:TRoleFunctionItem;
begin
 packdeliveryItem:=TPackdeliveryItem.Create;
  Reg.RegisterFunctionItem(packdeliveryItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管同城送货\',packdeliveryItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
