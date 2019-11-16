unit InitManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses InitManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var initManagerExport:TInitManagerExport;
begin
  initManagerExport:=TInitManagerExport.Create;
  Reg.RegisterFunctionItem(initManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\智能卡管理',initManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
