unit BalanceformulaExport;

{ ------------------------------------
  ����˵����Balanceformula.bpl�����Ԫ
  �������ڣ�2011.06.08
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses BalanceformulaPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  balanceformulaFunctionItem: TBalanceformulaFunctionItem;
begin
   //ע�Ṧ��
  balanceformulaFunctionItem := TBalanceformulaFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceformulaFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�������\����۷ѹ�ʽ����', balanceformulaFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
