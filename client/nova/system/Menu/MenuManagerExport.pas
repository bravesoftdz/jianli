{------------------------------------
  功能说明：MenuManager.bpl输出单元
  创建日期：2011.07.07
  作者：ice
  版权：nova
-------------------------------------}
unit MenuManagerExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  MenuManagerPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  MenuManager:TMenuManager;
begin
  MenuManager:=TMenuManager.Create;
  Reg.RegisterFunctionItem(MenuManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('系统管理\菜单管理', MenuManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
