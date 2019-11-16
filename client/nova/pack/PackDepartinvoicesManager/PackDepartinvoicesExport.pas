unit PackDepartinvoicesExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses PackDepartinvoicesPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  packDepartinvoicesPlugin: TPackDepartinvoicesPlugin;
begin
   //注册功能
  packDepartinvoicesPlugin := TPackDepartinvoicesPlugin.Create;
  Reg.RegisterFunctionItem(packDepartinvoicesPlugin);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('行包管理\行包结算单管理', packDepartinvoicesPlugin.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
