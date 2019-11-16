unit PackDepartinvoicesExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses PackDepartinvoicesPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  packDepartinvoicesPlugin: TPackDepartinvoicesPlugin;
begin
   //ע�Ṧ��
  packDepartinvoicesPlugin := TPackDepartinvoicesPlugin.Create;
  Reg.RegisterFunctionItem(packDepartinvoicesPlugin);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�а�����\�а����㵥����', packDepartinvoicesPlugin.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
