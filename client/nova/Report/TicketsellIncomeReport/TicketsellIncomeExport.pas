unit TicketsellIncomeExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses TicketsellIncomePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  ticketsellIncomeManager: TTicketsellIncomeManager;
  par: TFunctionItemParameters;

begin
  ticketsellIncomeManager := TTicketsellIncomeManager.Create;
  Reg.RegisterFunctionItem(ticketsellIncomeManager);
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
