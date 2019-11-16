unit QueryRemoteTicketsellManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRemoteTicketsellPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var queryRemoteTicketsell:queryRemoteTicketsellItem;
  par:TFunctionItemParameters;

begin
  queryRemoteTicketsell:=queryRemoteTicketsellItem.Create;
  Reg.RegisterFunctionItem(queryRemoteTicketsell);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('Ô¶³Ì¼ìÆ±²éÑ¯',queryRemoteTicketsell.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
