unit TicketReturnRateCfgManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketReturnRateCfgPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var TicketReturnRateCfgManager:TTicketReturnRateCfgManager;
begin
  TicketReturnRateCfgManager:=TTicketReturnRateCfgManager.Create;
  Reg.RegisterFunctionItem(TicketReturnRateCfgManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ������������',TicketReturnRateCfgManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
