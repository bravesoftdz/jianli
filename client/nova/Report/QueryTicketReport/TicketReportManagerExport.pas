unit TicketReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var TicketReportManagerExport: TTicketReportManagerExport;
begin
  TicketReportManagerExport:=TTicketReportManagerExport.Create;
  Reg.RegisterFunctionItem(TicketReportManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\车票使用汇总表',TicketReportManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
