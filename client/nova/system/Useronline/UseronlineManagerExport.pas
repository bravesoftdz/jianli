unit UseronlineManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses UseronlineManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var useronlineManagerExport:TUseronlineManagerExport;
begin
  useronlineManagerExport:=TUseronlineManagerExport.Create;
  Reg.RegisterFunctionItem(useronlineManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('系统管理\用户在线管理',useronlineManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
