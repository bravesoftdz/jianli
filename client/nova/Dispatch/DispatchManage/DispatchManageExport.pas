unit DispatchManageExport;
{ ------------------------------------
  ����˵����DispatchManage.bpl�����Ԫ
  �������ڣ�2011.05.6
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses DispatchManagePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  dispatchManageItemFunctionItem: TDispatchManageItemFunctionItem;
begin
   //ע�Ṧ��
  dispatchManageItemFunctionItem := TDispatchManageItemFunctionItem.Create;
  Reg.RegisterFunctionItem(dispatchManageItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('���ȹ���\�ۺϵ���', dispatchManageItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
