unit BalanceDivideExport;
{ ------------------------------------
  ����˵����BalanceDivide.bpl�����Ԫ
  �������ڣ�2012.08.24
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses BalanceDividePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  balancedivideFunctionItem: TBalanceDivideFunctionItem;
begin
   //ע�Ṧ��
  balancedivideFunctionItem := TBalanceDivideFunctionItem.Create;
  Reg.RegisterFunctionItem(balancedivideFunctionItem);
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
