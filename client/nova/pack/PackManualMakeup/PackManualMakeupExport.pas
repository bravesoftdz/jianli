unit PackManualMakeupExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackManualMakeupPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var FrmPackManualMakeupItem: TFrmPackManualMakeupItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmPackManualMakeupItem:=TFrmPackManualMakeupItem.Create;
  Reg.RegisterFunctionItem(FrmPackManualMakeupItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\行包日结算表',FrmPackManualMakeupItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
