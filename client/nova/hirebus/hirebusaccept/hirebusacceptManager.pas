unit hirebusacceptManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses hirebusacceptPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var hirebusacceptItem: ThirebusacceptItem;
//   roleListItem:TRoleFunctionItem;
begin
 hirebusacceptItem:=ThirebusacceptItem.Create;
  Reg.RegisterFunctionItem(hirebusacceptItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('包车管理\包车信息',hirebusacceptItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.


