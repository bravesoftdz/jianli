unit AdvanceTicketManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses AdvanceTicketManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var advanceTicketManagerExport: TAdvanceTicketManagerExport;
begin
  advanceTicketManagerExport:=TAdvanceTicketManagerExport.Create;
  Reg.RegisterFunctionItem(advanceTicketManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\Ԥ��Ʊ�����ѯ',advanceTicketManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
