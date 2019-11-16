unit SellReturnTicketManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses SellReturnTicketManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var sellReturnTicketManagerExport: TSellReturnTicketManagerExport;
begin
  sellReturnTicketManagerExport:=TSellReturnTicketManagerExport.Create;
  Reg.RegisterFunctionItem(sellReturnTicketManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('Íø¹º¶ÔÕË±¨±í',sellReturnTicketManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
