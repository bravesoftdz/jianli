unit OutstationupmoneyManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses OutstationupmoneyPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var OutstationupmoneyItem: TOutstationupmoneyItem;
//   roleListItem:TRoleFunctionItem;
begin
 OutstationupmoneyItem:=TOutstationupmoneyItem.Create;
  Reg.RegisterFunctionItem(OutstationupmoneyItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('结算管理\外站缴款单',OutstationupmoneyItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
