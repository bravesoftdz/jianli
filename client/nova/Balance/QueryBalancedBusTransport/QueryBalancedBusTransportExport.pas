unit QueryBalancedBusTransportExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryBalancedBusTransportPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryBalancedBusTransport:queryBalancedBusTransportManager;
  par:TFunctionItemParameters;

begin
  queryBalancedBusTransport:=queryBalancedBusTransportManager.Create;
  Reg.RegisterFunctionItem(queryBalancedBusTransport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('结算管理\已结算查询',queryBalancedBusTransport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
