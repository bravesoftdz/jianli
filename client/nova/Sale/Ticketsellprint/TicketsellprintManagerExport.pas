unit TicketsellprintManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketsellprintManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ticketsellprintManagerExport:TTicketsellprintManagerExport;
begin
  ticketsellprintManagerExport:=TTicketsellprintManagerExport.Create;
  Reg.RegisterFunctionItem(ticketsellprintManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('售票管理\重打车票',ticketsellprintManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
