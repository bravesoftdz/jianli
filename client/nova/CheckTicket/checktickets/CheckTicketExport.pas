unit CheckTicketExport;

{ ------------------------------------
  ����˵����CheckTicket.bpl�����Ԫ
  �������ڣ�2011.05.17
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses CheckTicketPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  checkTicketItemFunctionItem: TCheckTicketItemFunctionItem;
begin
  // ע�Ṧ��
  checkTicketItemFunctionItem := TCheckTicketItemFunctionItem.Create;
  Reg.RegisterFunctionItem(checkTicketItemFunctionItem);
 // checkBillItemFunctionItem := TCheckBillItemFunctionItem.Create;
 // Reg.RegisterFunctionItem(checkBillItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('��Ʊ����\�ۺϼ�Ʊ', checkTicketItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
