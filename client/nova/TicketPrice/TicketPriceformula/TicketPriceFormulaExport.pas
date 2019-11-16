unit TicketPriceFormulaExport;
{ ------------------------------------
  ����˵����TicketPriceFormula.bpl�����Ԫ
  �������ڣ�2011.03.12
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses TicketPriceFormulaPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  ticketPriceFormulaItemFunctionItem: TTicketPriceFormulaItemFunctionItem;
begin
   //ע�Ṧ��
  ticketPriceFormulaItemFunctionItem := TTicketPriceFormulaItemFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketPriceFormulaItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\Ʊ�۹�ʽ����', ticketPriceFormulaItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
