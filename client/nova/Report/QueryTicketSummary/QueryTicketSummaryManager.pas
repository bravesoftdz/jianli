unit QueryTicketSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryTicketSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryTicketSummary:queryTicketSummaryItem;
  par:TFunctionItemParameters;

begin
  queryTicketSummary:=queryTicketSummaryItem.Create;
  Reg.RegisterFunctionItem(queryTicketSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('站务分公司网点售票情况汇总表',queryTicketSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
