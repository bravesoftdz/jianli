unit SchedulePeikeReportExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses SchedulePeikeReportPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var schedulePeikeReportPlugin: TSchedulePeikeReportPlugin;
begin
  schedulePeikeReportPlugin:=TSchedulePeikeReportPlugin.Create;
  Reg.RegisterFunctionItem(schedulePeikeReportPlugin);
{$IFDEF DEBUG}

{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
