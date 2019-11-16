unit PrintItemSetExport;
 { ------------------------------------
  功能说明：PrintItemSet.bpl输出单元
  创建日期：2011.04.27
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses PrintItemSetPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  printItemSetFunctionItem: TPrintItemSetFunctionItem;
begin
   //注册功能
  printItemSetFunctionItem := TPrintItemSetFunctionItem.Create;
  Reg.RegisterFunctionItem(printItemSetFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('系统管理\不打印项目设置', printItemSetFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
