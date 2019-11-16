unit PackIntegrateRuleManager;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation
uses PackIntegrateRulePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  packIntegrateRule: TPackIntegrateRule;
begin
   //注册功能
  packIntegrateRule := TPackIntegrateRule.Create;
  Reg.RegisterFunctionItem(PackIntegrateRule);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('行包管理\积分规则设置', packIntegrateRule.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
