unit SchedulediscountManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses SchedulediscountManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var schManagerExport:TSchedulediscountManagerExport;
begin
  schManagerExport:=TSchedulediscountManagerExport.Create;
  Reg.RegisterFunctionItem(schManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\班次折扣管理',schManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
