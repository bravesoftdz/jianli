unit DeductitemExport;

{ ------------------------------------
  ����˵����Deductitem.bpl�����Ԫ
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
uses DeductitemPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  deductItemFunctionItem: TDeductItemFunctionItem;
begin
   //ע�Ṧ��
  deductItemFunctionItem := TDeductItemFunctionItem.Create;
  Reg.RegisterFunctionItem(deductItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�������\�̶��۷���Ŀ����', deductItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
