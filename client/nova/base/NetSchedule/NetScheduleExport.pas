unit NetScheduleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses NetSchedulePlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  netScheduleExport: TNetScheduleExport;
  test_parm: TFunctionItemParameters;
begin
  netScheduleExport := TNetScheduleExport.Create;
  Reg.RegisterFunctionItem(netScheduleExport);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
