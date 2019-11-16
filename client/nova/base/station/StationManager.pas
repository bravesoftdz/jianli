{------------------------------------
  功能说明：station.bpl输出单元
  创建日期：2011/01/22
  作者：蒋伟
  版权：nova
-------------------------------------}
unit StationManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var stationFunctionItem: TStationFunctionItem;
//   roleListItem:TRoleFunctionItem;
begin
 stationFunctionItem:=TStationFunctionItem.Create;
  Reg.RegisterFunctionItem(stationFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('业务管理\站点管理',stationFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
