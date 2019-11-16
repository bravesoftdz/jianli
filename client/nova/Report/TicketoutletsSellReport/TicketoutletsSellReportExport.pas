unit TicketoutletsSellReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses TicketoutletsSellReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  ticketoutletsSell:ticketoutletsSellMS;
begin
  ticketoutletsSell:=ticketoutletsSellMS.Create;
  reg.RegisterFunctionItem(ticketoutletsSell);

{$IFDEF DEBUG}
{$ENDIF}
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
