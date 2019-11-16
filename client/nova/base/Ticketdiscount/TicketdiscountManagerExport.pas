unit TicketdiscountManagerExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketdiscountManagerPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var discountManager:TicketdiscountManager;
  par:TFunctionItemParameters;

begin
  discountManager:=TicketdiscountManager.Create;
  Reg.RegisterFunctionItem(discountManager);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�ۿ۹���',discountManager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
