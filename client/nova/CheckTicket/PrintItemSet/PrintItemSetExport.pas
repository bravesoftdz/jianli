unit PrintItemSetExport;
 { ------------------------------------
  ����˵����PrintItemSet.bpl�����Ԫ
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
uses PrintItemSetPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  printItemSetFunctionItem: TPrintItemSetFunctionItem;
begin
   //ע�Ṧ��
  printItemSetFunctionItem := TPrintItemSetFunctionItem.Create;
  Reg.RegisterFunctionItem(printItemSetFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('ϵͳ����\����ӡ��Ŀ����', printItemSetFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
