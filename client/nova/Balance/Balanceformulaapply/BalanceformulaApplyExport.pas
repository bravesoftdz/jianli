unit BalanceformulaApplyExport;


{ ------------------------------------
  ����˵����BalanceformulaApply.bpl�����Ԫ
  �������ڣ�2011.06.11
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses BalanceformulaApplyPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  balanceformulaApplyPlugin: TBalanceformulaApplyFunctionItem;
begin
   //ע�Ṧ��
  balanceformulaApplyPlugin := TBalanceformulaApplyFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceformulaApplyPlugin);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�������\����۷ѹ�ʽӦ��', balanceformulaApplyPlugin.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
