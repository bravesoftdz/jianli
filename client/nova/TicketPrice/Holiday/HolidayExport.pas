unit HolidayExport;
{ ------------------------------------
  ����˵����Holiday.bpl�����Ԫ
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
uses HolidayPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  holidayItemFunctionItem: THolidayItemFunctionItem;
begin
   //ע�Ṧ��
  holidayItemFunctionItem := THolidayItemFunctionItem.Create;
  Reg.RegisterFunctionItem(holidayItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\������Ϣ', holidayItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
