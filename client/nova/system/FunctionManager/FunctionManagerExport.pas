{------------------------------------
  功能说明：FunctionManager.bpl输出单元
  创建日期：2011.07.01
  作者：ice
  版权：nova
-------------------------------------}
unit FunctionManagerExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  FunctionManagerPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  FunctionManager:TFunctionManager;
begin
  FunctionManager:=TFunctionManager.Create;
  Reg.RegisterFunctionItem(FunctionManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('系统管理\功能管理', FunctionManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
