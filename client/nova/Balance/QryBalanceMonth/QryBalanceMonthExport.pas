unit QryBalanceMonthExport;


interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses QryBalanceMonthPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  balanceFunctionItem: TBalanceMonthFunctionItem;
begin
  // ע�Ṧ��
  balanceFunctionItem := TBalanceMonthFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
