{------------------------------------
  ����˵����PrintTemplate.bpl�����Ԫ
  �������ڣ�2011.03.04
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit PrintTemplateExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  PrintTemplatePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  printTemplateManager: TPrintTemplateManager;
  printTemplateTypeManager:TPrintTemplateTypeManager;
begin
  printTemplateManager := TprintTemplateManager.Create;
  Reg.RegisterFunctionItem(printTemplateManager);
  printTemplateTypeManager:=TprintTemplateTypeManager.Create;
  Reg.RegisterFunctionItem(printTemplateTypeManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('ϵͳ����\��ӡģ�����͹���', printTemplateTypeManager.key, nil);
    (SysService as IMainForm).CreateMenu('ϵͳ����\��ӡģ�����', printTemplateManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
