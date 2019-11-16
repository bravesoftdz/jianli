unit TicketChargeoffExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketChargeoffPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var  ticketChargeoff:TicketChargeoffMS;
  par:TFunctionItemParameters;

begin
  ticketChargeoff:=TicketChargeoffMS.Create;
  Reg.RegisterFunctionItem(ticketChargeoff);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�������\Ʊ�ݺ���',ticketChargeoff.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
