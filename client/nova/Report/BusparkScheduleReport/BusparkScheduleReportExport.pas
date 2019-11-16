unit BusparkScheduleReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses BusparkScheduleReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  BusparkScheduleReport:TBusparkScheduleReport;
begin
  BusparkScheduleReport:=TBusparkScheduleReport.Create;
  reg.RegisterFunctionItem(BusparkScheduleReport);
{$IFDEF DEBUG}
{$ENDIF}
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
