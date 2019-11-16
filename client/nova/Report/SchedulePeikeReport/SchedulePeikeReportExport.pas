unit SchedulePeikeReportExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SchedulePeikeReportPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var schedulePeikeReportPlugin: TSchedulePeikeReportPlugin;
begin
  schedulePeikeReportPlugin:=TSchedulePeikeReportPlugin.Create;
  Reg.RegisterFunctionItem(schedulePeikeReportPlugin);
{$IFDEF DEBUG}

{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
