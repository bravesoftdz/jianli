unit SameCityDeliveryExport;

{ ------------------------------------
  ����˵����SameCityDelivery.bpl�����Ԫ
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
uses SameCityDeliveryPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  SameCityDeliveryFunctionItem: TSameCityDeliveryFunctionItem;
begin
   //ע�Ṧ��
  SameCityDeliveryFunctionItem := TSameCityDeliveryFunctionItem.Create;
  Reg.RegisterFunctionItem(SameCityDeliveryFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
