unit StandardPriceExport;

{ ------------------------------------
  ����˵����StandardPrice.bpl�����Ԫ
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
uses StandardPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  standardPriceFunctionItem: TStandardPriceFunctionItem;
begin
   //ע�Ṧ��
  standardPriceFunctionItem := TStandardPriceFunctionItem.Create;
  Reg.RegisterFunctionItem(standardPriceFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\��ʽƱ��', standardPriceFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
