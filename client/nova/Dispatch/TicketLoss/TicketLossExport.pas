unit TicketLossExport;

{ ------------------------------------
  ����˵����TicketLoss.bpl�����Ԫ
  �������ڣ�2011.06.03
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses TicketLossPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  TicketLossFunctionItem: TTicketLossFunctionItem;
begin
   //ע�Ṧ��
  TicketLossFunctionItem := TTicketLossFunctionItem.Create;
  Reg.RegisterFunctionItem(TicketLossFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
