unit DistrictManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses DistrictPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var districtManager:TDistrictManager;
begin
  districtManager:=TDistrictManager.Create;
  Reg.RegisterFunctionItem(districtManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\区域管理',districtManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
