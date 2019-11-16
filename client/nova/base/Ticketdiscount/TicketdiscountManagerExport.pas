unit TicketdiscountManagerExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketdiscountManagerPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var discountManager:TicketdiscountManager;
  par:TFunctionItemParameters;

begin
  discountManager:=TicketdiscountManager.Create;
  Reg.RegisterFunctionItem(discountManager);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ÕÛ¿Û¹ÜÀí',discountManager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
