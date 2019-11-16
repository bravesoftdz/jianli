unit StationPriceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses StationPricePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var stationprice:StationpriceManager;
  par:TFunctionItemParameters;

begin
  stationprice:=StationpriceManager.Create;
  Reg.RegisterFunctionItem(stationprice);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('票价管理\站点平时票价管理',stationprice.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
