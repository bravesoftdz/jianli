unit QuerySchedulePriceExport;
{ ------------------------------------
  ����˵����QueryschedulePrice.bpl�����Ԫ
  �������ڣ�2011.07.13
  ���ߣ�hhz
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses QuerySchedulePricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  queryschedulePrice:querySchedulePriceManage;
begin
   //ע�Ṧ��
  queryschedulePrice := querySchedulePriceManage.Create;
  Reg.RegisterFunctionItem(queryschedulePrice);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۲�ѯ\���Ʊ�۲�ѯ', queryschedulePrice.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
