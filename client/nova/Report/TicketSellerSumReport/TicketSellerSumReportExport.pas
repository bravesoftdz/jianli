unit TicketSellerSumReportExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketSellerSumReportPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketSellerSumReportExport:TTicketSellerSumReportExport;
begin
  ticketSellerSumReportExport:=TTicketSellerSumReportExport.Create;
  Reg.RegisterFunctionItem(ticketSellerSumReportExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\�������������ѯ',ticketSellerSumReportExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
