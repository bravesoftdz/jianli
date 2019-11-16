{ ------------------------------------
  功能说明：About.bpl输出单元
  创建日期：2011/08/10
  作者：lck
  版权：nova
  ------------------------------------- }
unit AboutExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses AboutPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  aboutFunctionItem: TAboutFunctionItem;
begin
  aboutFunctionItem := TAboutFunctionItem.Create;
  Reg.RegisterFunctionItem(aboutFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('帮助\关于', aboutFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
