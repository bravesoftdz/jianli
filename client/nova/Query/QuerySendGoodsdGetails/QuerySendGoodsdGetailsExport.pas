unit QuerySendGoodsdGetailsExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QuerySendGoodsdGetailsPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var FrmQuerySendGoodsdGetailsItem: TFrmQuerySendGoodsdGetailsItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmQuerySendGoodsdGetailsItem:=TFrmQuerySendGoodsdGetailsItem.Create;
  Reg.RegisterFunctionItem(FrmQuerySendGoodsdGetailsItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\行包查询\发货查询',FrmQuerySendGoodsdGetailsItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
