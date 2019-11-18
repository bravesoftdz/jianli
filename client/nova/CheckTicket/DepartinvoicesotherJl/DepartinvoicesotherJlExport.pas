unit DepartinvoicesotherJlExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  DepartinvoicesotherJlPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  departinvoicesJlFunction: TDepartinvoicesotherJlFunction;
  parameters:TFunctionItemParameters;
begin
  departinvoicesJlFunction := TDepartinvoicesotherJlFunction.Create;
  Reg.RegisterFunctionItem(departinvoicesJlFunction);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('½áËãµ¥²¹Â¼(¼àÀû)', departinvoicesJlFunction.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
