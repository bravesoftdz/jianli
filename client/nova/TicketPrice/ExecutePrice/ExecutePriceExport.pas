unit ExecutePriceExport;
{ ------------------------------------
  ����˵����ExecutePrice.bpl�����Ԫ
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
uses ExecutePricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  executePriceItemFunctionItem: TExecutePriceItemFunctionItem;
begin
   //ע�Ṧ��
  executePriceItemFunctionItem := TExecutePriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(executePriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\Ӫ�˼ƻ�����', executePriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
