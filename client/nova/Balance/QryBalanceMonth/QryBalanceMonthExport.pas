unit QryBalanceMonthExport;


interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses QryBalanceMonthPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  balanceFunctionItem: TBalanceMonthFunctionItem;
begin
  // ×¢²á¹¦ÄÜ
  balanceFunctionItem := TBalanceMonthFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceFunctionItem);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
