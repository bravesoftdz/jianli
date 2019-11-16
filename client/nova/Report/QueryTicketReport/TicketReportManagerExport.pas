unit TicketReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var TicketReportManagerExport: TTicketReportManagerExport;
begin
  TicketReportManagerExport:=TTicketReportManagerExport.Create;
  Reg.RegisterFunctionItem(TicketReportManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\��Ʊʹ�û��ܱ�',TicketReportManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
