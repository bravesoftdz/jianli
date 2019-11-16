unit TicketoutletsSellReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses TicketoutletsSellReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  ticketoutletsSell:ticketoutletsSellMS;
begin
  ticketoutletsSell:=ticketoutletsSellMS.Create;
  reg.RegisterFunctionItem(ticketoutletsSell);

{$IFDEF DEBUG}
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
