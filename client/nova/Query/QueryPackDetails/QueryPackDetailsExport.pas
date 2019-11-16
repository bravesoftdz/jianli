unit QueryPackDetailsExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackDetailsPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryPackDetailsPluginItem: TQueryPackDetailsPluginItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackDetailsPluginItem:=TQueryPackDetailsPluginItem.Create;
  Reg.RegisterFunctionItem(QueryPackDetailsPluginItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\行包查询\前台明细',QueryPackDetailsPluginItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
