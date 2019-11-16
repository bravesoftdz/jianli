unit InsureReturnManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsureReturnPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var isurerurnFunctionItem: TInsureReturnFunctionItem;
begin
 isurerurnFunctionItem:=TInsureReturnFunctionItem.Create;
  Reg.RegisterFunctionItem(isurerurnFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('售票管理\单独退保险',isurerurnFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
