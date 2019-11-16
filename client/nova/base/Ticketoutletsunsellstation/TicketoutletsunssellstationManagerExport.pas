unit TicketoutletsunssellstationManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletsunssellstationManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ticketoutletsunssellstationManagerExport:TTicketoutletsunssellstationManagerExport;
begin
  ticketoutletsunssellstationManagerExport:=TTicketoutletsunssellstationManagerExport.Create;
  Reg.RegisterFunctionItem(ticketoutletsunssellstationManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\售票点不可售站点控制',ticketoutletsunssellstationManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
