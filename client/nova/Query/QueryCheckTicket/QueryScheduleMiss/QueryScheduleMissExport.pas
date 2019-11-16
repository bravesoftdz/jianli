unit QueryScheduleMissExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryScheduleMissPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var queryScheduleMiss:queryScheduleMissManager;
  par:TFunctionItemParameters;

begin
  queryScheduleMiss:=queryScheduleMissManager.Create;
  Reg.RegisterFunctionItem(queryScheduleMiss);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('¼ìÆ±²éÑ¯\°à´ÎÂ©³ËÇé¿ö²éÑ¯',queryScheduleMiss.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
