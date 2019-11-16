unit DepartinvoicesotherSimpleExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;
implementation
uses DepartinvoicesotherSimplePlugin;


procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  DepartinvoicesotherSimpleFunctionItem: TDepartinvoicesotherSimpleFunctionItem;
begin
   //×¢²á¹¦ÄÜ
  DepartinvoicesotherSimpleFunctionItem := TDepartinvoicesotherSimpleFunctionItem.Create;
  Reg.RegisterFunctionItem(DepartinvoicesotherSimpleFunctionItem);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization
end.
