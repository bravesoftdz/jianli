unit InsuretypeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsuretypeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var insuretypeManagerExport:TInsuretypeManagerExport;
begin
  insuretypeManagerExport:=TInsuretypeManagerExport.Create;
  Reg.RegisterFunctionItem(insuretypeManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\保险类型',insuretypeManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
