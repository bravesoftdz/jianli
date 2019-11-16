unit GpscheckManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses GpscheckManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var gpscheckManagerExport:TGpscheckManagerExport;
begin
 gpscheckManagerExport:=TGpscheckManagerExport.Create;
  Reg.RegisterFunctionItem(gpscheckManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\结算单补录',gpscheckManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
