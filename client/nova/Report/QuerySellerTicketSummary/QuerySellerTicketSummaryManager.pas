unit QuerySellerTicketSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySellerTicketSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var QuerySellerTicketSummary:QuerySellerTicketSummaryItem;
  par:TFunctionItemParameters;

begin
  QuerySellerTicketSummary:=QuerySellerTicketSummaryItem.Create;
  Reg.RegisterFunctionItem(QuerySellerTicketSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('站务分公司售票员售票情况汇总表',QuerySellerTicketSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
