unit SellReturnTicketManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SellReturnTicketManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var sellReturnTicketManagerExport: TSellReturnTicketManagerExport;
begin
  sellReturnTicketManagerExport:=TSellReturnTicketManagerExport.Create;
  Reg.RegisterFunctionItem(sellReturnTicketManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������˱���',sellReturnTicketManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
