unit TicketoutletsunssellstationManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletsunssellstationManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketoutletsunssellstationManagerExport:TTicketoutletsunssellstationManagerExport;
begin
  ticketoutletsunssellstationManagerExport:=TTicketoutletsunssellstationManagerExport.Create;
  Reg.RegisterFunctionItem(ticketoutletsunssellstationManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ�㲻����վ�����',ticketoutletsunssellstationManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
