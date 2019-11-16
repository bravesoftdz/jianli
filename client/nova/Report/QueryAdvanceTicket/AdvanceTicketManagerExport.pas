unit AdvanceTicketManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses AdvanceTicketManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var advanceTicketManagerExport: TAdvanceTicketManagerExport;
begin
  advanceTicketManagerExport:=TAdvanceTicketManagerExport.Create;
  Reg.RegisterFunctionItem(advanceTicketManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\预售票情况查询',advanceTicketManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
