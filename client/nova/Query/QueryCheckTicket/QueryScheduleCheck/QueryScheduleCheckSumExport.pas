unit QueryScheduleCheckSumExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryScheduleCheckSumPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var par:TFunctionItemParameters;
  qryScheduleCheckSum:TQryScheduleCheckSum;
begin
  qryScheduleCheckSum:=TQryScheduleCheckSum.create;
  Reg.RegisterFunctionItem(qryScheduleCheckSum);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('¼ìÆ±²éÑ¯\°à´Î¼ìÆ±»ã×Ü±í',qryScheduleCheckSum.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
