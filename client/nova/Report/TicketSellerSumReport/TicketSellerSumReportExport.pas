unit TicketSellerSumReportExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketSellerSumReportPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ticketSellerSumReportExport:TTicketSellerSumReportExport;
begin
  ticketSellerSumReportExport:=TTicketSellerSumReportExport.Create;
  Reg.RegisterFunctionItem(ticketSellerSumReportExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('售票查询\保险销售情况查询',ticketSellerSumReportExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
