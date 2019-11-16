unit TicketmixcheckManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketmixcheckManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketmixcheckManagerExport: TTicketmixcheckManagerExport;
begin
  ticketmixcheckManagerExport:=TTicketmixcheckManagerExport.Create;
  Reg.RegisterFunctionItem(ticketmixcheckManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ��ѯ\����ѯ',ticketmixcheckManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
