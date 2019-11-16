unit QueryOrgDataSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryOrgDataSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryOrgDataSummary:QueryOrgDataSummaryItem;
  par:TFunctionItemParameters;

begin
  QueryOrgDataSummary:=QueryOrgDataSummaryItem.Create;
  Reg.RegisterFunctionItem(QueryOrgDataSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('站务作业统计报表',QueryOrgDataSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
