unit HandHolidayPriceExport;
{ ------------------------------------
  ����˵����HandHolidayPrice.bpl�����Ԫ
  �������ڣ�2011.04.27
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses HandHolidayPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  handHolidayPriceItemFunctionItem: THandHolidayPriceItemFunctionItem;
begin
   //ע�Ṧ��
  handHolidayPriceItemFunctionItem := THandHolidayPriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(handHolidayPriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\����Ʊ�۹���', handHolidayPriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
