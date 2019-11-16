unit PackIntegrateRuleManager;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation
uses PackIntegrateRulePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  packIntegrateRule: TPackIntegrateRule;
begin
   //ע�Ṧ��
  packIntegrateRule := TPackIntegrateRule.Create;
  Reg.RegisterFunctionItem(PackIntegrateRule);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�а�����\���ֹ�������', packIntegrateRule.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
