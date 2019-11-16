unit QryFullSeatScheduleExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QryFullSeatSchedulePlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var fullSeatSchedule:fullSeatScheduleManager;
  par:TFunctionItemParameters;

begin
  fullSeatSchedule:=fullSeatScheduleManager.Create;
  Reg.RegisterFunctionItem(fullSeatSchedule);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('¼ìÆ±²éÑ¯\Âú×ù°à´ÎÇé¿ö²éÑ¯',fullSeatSchedule.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
