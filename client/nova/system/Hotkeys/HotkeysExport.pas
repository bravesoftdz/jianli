{------------------------------------
  功能说明：Hotkeys.bpl输出单元
  创建日期：2011.07.13
  作者：ice
  版权：nova
-------------------------------------}
unit HotkeysExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  HotkeysPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  HotkeysManager:THotkeysManager;
begin
  HotkeysManager:=THotkeysManager.Create;
  Reg.RegisterFunctionItem(HotkeysManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('系统管理\快捷键设置', HotkeysManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
