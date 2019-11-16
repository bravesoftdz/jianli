unit NetScheduleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses NetSchedulePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  netScheduleExport: TNetScheduleExport;
  test_parm: TFunctionItemParameters;
begin
  netScheduleExport := TNetScheduleExport.Create;
  Reg.RegisterFunctionItem(netScheduleExport);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
