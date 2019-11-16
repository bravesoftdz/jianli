unit QueryRouteDataSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRouteDataSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querysrouteDynamicCompare:routeDynamicCompareManager;
  par:TFunctionItemParameters;

begin
  querysrouteDynamicCompare:=routeDynamicCompareManager.Create;
  Reg.RegisterFunctionItem(querysrouteDynamicCompare);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('站务分公司班线数据情况汇总表',querysrouteDynamicCompare.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
