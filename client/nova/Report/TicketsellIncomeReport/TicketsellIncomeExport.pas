unit TicketsellIncomeExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses TicketsellIncomePlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  ticketsellIncomeManager: TTicketsellIncomeManager;
  par: TFunctionItemParameters;

begin
  ticketsellIncomeManager := TTicketsellIncomeManager.Create;
  Reg.RegisterFunctionItem(ticketsellIncomeManager);
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
