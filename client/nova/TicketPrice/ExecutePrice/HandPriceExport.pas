unit HandPriceExport;
{ ------------------------------------
  ����˵����HandPrice.bpl�����Ԫ
  �������ڣ�2011.03.16
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses HandPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  ticketPriceItemFunctionItem: TTicketPriceItemFunctionItem;
begin
   //ע�Ṧ��
  ticketPriceItemFunctionItem := TTicketPriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketPriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\Ӳ��Ʊ�۹���', ticketPriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.