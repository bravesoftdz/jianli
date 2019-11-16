unit QueryNetworkTicketSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryNetworkTicketSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querysrouteDynamicCompare:routeDynamicCompareManager;
  par:TFunctionItemParameters;

begin
  querysrouteDynamicCompare:=routeDynamicCompareManager.Create;
  Reg.RegisterFunctionItem(querysrouteDynamicCompare);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('联网售票统计报表',querysrouteDynamicCompare.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
