unit TicketdeliverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketdeliverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var ticketdeliverManagerExport:TTicketdeliverManagerExport;
begin
  ticketdeliverManagerExport:=TTicketdeliverManagerExport.Create;
  Reg.RegisterFunctionItem(ticketdeliverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ÊÛÆ±¹ÜÀí\ËÍÆ±µÇ¼Ç',ticketdeliverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
