unit TicketoutletStrExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletStrPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var TicketoutletStrExport:TTicketoutletStrExport;

begin
  TicketoutletStrExport:=TTicketoutletStrExport.Create;
  Reg.RegisterFunctionItem(TicketoutletStrExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('售票查询\保险销售情况查询',TicketoutletStrExport.key,nil);
  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
