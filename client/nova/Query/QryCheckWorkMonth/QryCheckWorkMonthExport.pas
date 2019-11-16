unit QryCheckWorkMonthExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QryCheckWorkMonthPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QryCheckWorkMonthPluginItem: TQryCheckWorkMonthPluginItem;
//   roleListItem:TRoleFunctionItem;
begin
 QryCheckWorkMonthPluginItem:=TQryCheckWorkMonthPluginItem.Create;
  Reg.RegisterFunctionItem(QryCheckWorkMonthPluginItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('综合查询\检票查询\检票工作月报',QryCheckWorkMonthPluginItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
