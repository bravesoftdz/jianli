unit QryPackMonthBalanceExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses QryPackMonthBalancePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  PackMonthBalanceItem:TPackMonthBalanceItem;
begin
   //ע�Ṧ��
  PackMonthBalanceItem := TPackMonthBalanceItem.Create;
  Reg.RegisterFunctionItem(PackMonthBalanceItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�а�����\�����½����', PackMonthBalanceItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
