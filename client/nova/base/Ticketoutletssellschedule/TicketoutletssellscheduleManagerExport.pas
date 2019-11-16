unit TicketoutletssellscheduleManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletssellscheduleManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketoutletssellscheduleManagerExport:TTicketoutletssellscheduleManagerExport;
begin
  ticketoutletssellscheduleManagerExport:=TTicketoutletssellscheduleManagerExport.Create;
  Reg.RegisterFunctionItem(ticketoutletssellscheduleManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ����۰�ο���',ticketoutletssellscheduleManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
