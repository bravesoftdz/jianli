unit QueryDrawVehSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDrawVehSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryDrawVehSummary:queryDrawVehSummaryItem;
  par:TFunctionItemParameters;

begin
  queryDrawVehSummary:=queryDrawVehSummaryItem.Create;
  Reg.RegisterFunctionItem(queryDrawVehSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('站务分公司进站车辆汇总表',queryDrawVehSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
