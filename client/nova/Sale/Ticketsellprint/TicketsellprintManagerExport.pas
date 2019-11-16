unit TicketsellprintManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketsellprintManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketsellprintManagerExport:TTicketsellprintManagerExport;
begin
  ticketsellprintManagerExport:=TTicketsellprintManagerExport.Create;
  Reg.RegisterFunctionItem(ticketsellprintManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ����\�ش�Ʊ',ticketsellprintManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
