unit PublicQryExport;

{ ------------------------------------
  ����˵����ExplorerTest.bpl�����Ԫ
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
uses PublicQryPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  ExplorerTestFunctionItem: TPublicQryFunctionItem;
begin
   //ע�Ṧ��
  ExplorerTestFunctionItem := TPublicQryFunctionItem.Create;
  Reg.RegisterFunctionItem(ExplorerTestFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
