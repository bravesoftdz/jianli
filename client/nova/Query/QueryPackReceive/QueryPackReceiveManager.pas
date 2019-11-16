unit QueryPackReceiveManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackReceivePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryPackReceiveItem: TQueryPackReceiveItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackReceiveItem:=TQueryPackReceiveItem.Create;
  Reg.RegisterFunctionItem(QueryPackReceiveItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\行包查询\行包提领营收统计',QueryPackReceiveItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
