unit QueryBalancedBusTransportExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryBalancedBusTransportPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryBalancedBusTransport:queryBalancedBusTransportManager;
  par:TFunctionItemParameters;

begin
  queryBalancedBusTransport:=queryBalancedBusTransportManager.Create;
  Reg.RegisterFunctionItem(queryBalancedBusTransport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�������\�ѽ����ѯ',queryBalancedBusTransport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
