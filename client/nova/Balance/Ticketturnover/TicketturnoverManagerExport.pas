unit TicketturnoverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketturnoverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ticketturnoverManagerExport:TTicketturnoverManagerExport;
begin
  ticketturnoverManagerExport:=TTicketturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(ticketturnoverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\售票员营收缴款',ticketturnoverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
