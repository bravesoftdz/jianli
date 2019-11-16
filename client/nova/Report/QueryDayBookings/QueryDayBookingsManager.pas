unit QueryDayBookingsManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDayBookingsPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var queryDayBookings:queryDayBookingsItem;
  par:TFunctionItemParameters;

begin
  queryDayBookings:=queryDayBookingsItem.Create;
  Reg.RegisterFunctionItem(queryDayBookings);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('Ô¤ÊÛÆ±ÈÕ±¨±í',queryDayBookings.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
