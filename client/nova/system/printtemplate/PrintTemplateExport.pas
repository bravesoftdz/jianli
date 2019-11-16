{------------------------------------
  功能说明：PrintTemplate.bpl输出单元
  创建日期：2011.03.04
  作者：ice
  版权：nova
-------------------------------------}
unit PrintTemplateExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  PrintTemplatePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  printTemplateManager: TPrintTemplateManager;
  printTemplateTypeManager:TPrintTemplateTypeManager;
begin
  printTemplateManager := TprintTemplateManager.Create;
  Reg.RegisterFunctionItem(printTemplateManager);
  printTemplateTypeManager:=TprintTemplateTypeManager.Create;
  Reg.RegisterFunctionItem(printTemplateTypeManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('系统管理\打印模板类型管理', printTemplateTypeManager.key, nil);
    (SysService as IMainForm).CreateMenu('系统管理\打印模板管理', printTemplateManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
