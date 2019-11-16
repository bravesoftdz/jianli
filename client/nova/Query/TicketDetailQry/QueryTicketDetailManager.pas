unit QueryTicketDetailManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryTicketDetailPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var queryTicketDetail:queryTicketDetailItem;
  par:TFunctionItemParameters;

begin
  queryTicketDetail:=queryTicketDetailItem.Create;
  Reg.RegisterFunctionItem(queryTicketDetail);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('µç×ÓÆ±Ã÷Ï¸²éÑ¯',queryTicketDetail.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
