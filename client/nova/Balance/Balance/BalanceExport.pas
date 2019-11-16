unit BalanceExport;


{ ------------------------------------
  ����˵����Balance.bpl�����Ԫ
  �������ڣ�2011.06.22
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses BalancePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  balanceFunctionItem: TBalanceFunctionItem;
  packbalance: TPackBalance;
  packarrive: TPackArrive;
begin
   //ע�Ṧ��
  balanceFunctionItem := TBalanceFunctionItem.Create;
  Reg.RegisterFunctionItem(balanceFunctionItem);
  packbalance := TPackBalance.Create;
  Reg.RegisterFunctionItem(packbalance);
  packarrive := TPackArrive.Create;
  Reg.RegisterFunctionItem(packarrive);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�������\���㵥����', balanceFunctionItem.key, nil);
(SysService as IMainForm)
  .CreateMenu('�а�����\�������', packarrive.key, nil);
(SysService as IMainForm)
  .CreateMenu('�а�����\ǰ̨����', packbalance.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
