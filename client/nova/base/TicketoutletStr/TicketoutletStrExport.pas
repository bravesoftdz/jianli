unit TicketoutletStrExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletStrPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var TicketoutletStrExport:TTicketoutletStrExport;

begin
  TicketoutletStrExport:=TTicketoutletStrExport.Create;
  Reg.RegisterFunctionItem(TicketoutletStrExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\�������������ѯ',TicketoutletStrExport.key,nil);
  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
