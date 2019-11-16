unit ViolationManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses ViolationManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var violationManagerExport:TViolationManagerExport;
begin
  violationManagerExport:=TViolationManagerExport.Create;
  Reg.RegisterFunctionItem(violationManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\营运车辆违规处理',violationManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
