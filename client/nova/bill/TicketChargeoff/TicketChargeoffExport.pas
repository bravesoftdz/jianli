unit TicketChargeoffExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketChargeoffPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var  ticketChargeoff:TicketChargeoffMS;
  par:TFunctionItemParameters;

begin
  ticketChargeoff:=TicketChargeoffMS.Create;
  Reg.RegisterFunctionItem(ticketChargeoff);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('结算管理\票据核销',ticketChargeoff.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
