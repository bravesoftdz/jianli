unit TicketTurnOverOtherExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;
implementation
uses TicketTurnOverOtherPlugin;


procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  TicketTurnOverOther: TicketTurnOverOtherFunction;
begin
   //×¢²á¹¦ÄÜ
  TicketTurnOverOther := TicketTurnOverOtherFunction.Create;
  Reg.RegisterFunctionItem(TicketTurnOverOther);
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization
end.
