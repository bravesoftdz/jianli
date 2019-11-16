unit QueryBalanceitemManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryBalanceitemManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var balanceitemManagerExport:TBalanceitemManagerExport;
var qryTakeTicketLogManagerExport:TQryTakeTicketLogManagerExport;
begin
  balanceitemManagerExport:=TBalanceitemManagerExport.Create;
  Reg.RegisterFunctionItem(balanceitemManagerExport);
  qryTakeTicketLogManagerExport:=TQryTakeTicketLogManagerExport.Create;
  Reg.RegisterFunctionItem(qryTakeTicketLogManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\营运结算明细表',balanceitemManagerExport.key,nil);
  (SysService as  IMainForm).CreateMenu('系统管理\取票日志查询',qryTakeTicketLogManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
