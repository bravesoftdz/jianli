unit DepartinvoicesotherTicketnoExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses DepartinvoicesotherTicketnoPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var departinvoicesotherTicketnoExport:TDepartinvoicesotherTicketnoExport;

begin
  departinvoicesotherTicketnoExport:=TDepartinvoicesotherTicketnoExport.Create;
  Reg.RegisterFunctionItem(departinvoicesotherTicketnoExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\结算单补录',departinvoicesotherTicketnoExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
