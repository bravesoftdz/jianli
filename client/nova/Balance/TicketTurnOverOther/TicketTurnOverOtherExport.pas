unit TicketTurnOverOtherExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses TicketTurnOverOtherPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  TicketTurnOverOther: TicketTurnOverOtherFunction;
begin
   //ע�Ṧ��
  TicketTurnOverOther := TicketTurnOverOtherFunction.Create;
  Reg.RegisterFunctionItem(TicketTurnOverOther);
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
