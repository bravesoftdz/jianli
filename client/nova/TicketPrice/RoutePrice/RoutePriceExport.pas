unit RoutePriceExport;

{ ------------------------------------
  ����˵����RoutePrice.bpl�����Ԫ
  �������ڣ�2014.12.18
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses RoutePricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  routePriceItemFunctionItem: TRoutePriceItemFunctionItem;
begin
   //ע�Ṧ��
  routePriceItemFunctionItem := TRoutePriceItemFunctionItem.Create;
  Reg.RegisterFunctionItem(routePriceItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\��·Ʊ����Ϣ', routePriceItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
