unit DepartinvoicesotherSimpleExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses DepartinvoicesotherSimplePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  DepartinvoicesotherSimpleFunctionItem: TDepartinvoicesotherSimpleFunctionItem;
begin
   //ע�Ṧ��
  DepartinvoicesotherSimpleFunctionItem := TDepartinvoicesotherSimpleFunctionItem.Create;
  Reg.RegisterFunctionItem(DepartinvoicesotherSimpleFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
