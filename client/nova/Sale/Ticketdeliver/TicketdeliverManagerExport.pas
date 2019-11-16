unit TicketdeliverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketdeliverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketdeliverManagerExport:TTicketdeliverManagerExport;
begin
  ticketdeliverManagerExport:=TTicketdeliverManagerExport.Create;
  Reg.RegisterFunctionItem(ticketdeliverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ����\��Ʊ�Ǽ�',ticketdeliverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
