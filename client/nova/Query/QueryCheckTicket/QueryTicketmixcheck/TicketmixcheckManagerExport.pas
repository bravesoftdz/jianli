unit TicketmixcheckManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketmixcheckManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var ticketmixcheckManagerExport: TTicketmixcheckManagerExport;
begin
  ticketmixcheckManagerExport:=TTicketmixcheckManagerExport.Create;
  Reg.RegisterFunctionItem(ticketmixcheckManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('×ÛºÏ²éÑ¯\¼ìÆ±²éÑ¯\»ì¼ì²éÑ¯',ticketmixcheckManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
