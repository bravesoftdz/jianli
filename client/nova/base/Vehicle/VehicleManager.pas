{------------------------------------
  功能说明：Vehicle.bpl输出单元
  创建日期：2011/01/22
  作者：蒋伟
  版权：nova
-------------------------------------}
unit VehicleManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehiclePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleFunctionItem:TVehicleFunctionItem;
begin
 vehicleFunctionItem:=TVehicleFunctionItem.Create;
  Reg.RegisterFunctionItem(vehicleFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('业务管理\车辆管理',vehicleFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
