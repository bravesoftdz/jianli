unit BusparkScheduleReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses BusparkScheduleReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  BusparkScheduleReport:TBusparkScheduleReport;
begin
  BusparkScheduleReport:=TBusparkScheduleReport.Create;
  reg.RegisterFunctionItem(BusparkScheduleReport);
{$IFDEF DEBUG}
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
