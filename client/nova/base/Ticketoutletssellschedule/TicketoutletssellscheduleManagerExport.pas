unit TicketoutletssellscheduleManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletssellscheduleManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ticketoutletssellscheduleManagerExport:TTicketoutletssellscheduleManagerExport;
begin
  ticketoutletssellscheduleManagerExport:=TTicketoutletssellscheduleManagerExport.Create;
  Reg.RegisterFunctionItem(ticketoutletssellscheduleManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\售票点可售班次控制',ticketoutletssellscheduleManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
