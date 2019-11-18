unit DepartinvoicesotherJlExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  DepartinvoicesotherJlPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  departinvoicesJlFunction: TDepartinvoicesotherJlFunction;
  parameters:TFunctionItemParameters;
begin
  departinvoicesJlFunction := TDepartinvoicesotherJlFunction.Create;
  Reg.RegisterFunctionItem(departinvoicesJlFunction);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('���㵥��¼(����)', departinvoicesJlFunction.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
