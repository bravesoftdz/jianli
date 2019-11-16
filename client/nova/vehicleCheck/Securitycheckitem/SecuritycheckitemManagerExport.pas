unit SecuritycheckitemManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses SecuritycheckitemManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var securitycheckitemManagerExport:TSecuritycheckitemManagerExport;
begin
  securitycheckitemManagerExport:=TSecuritycheckitemManagerExport.Create;
  Reg.RegisterFunctionItem(securitycheckitemManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('安检管理\车辆安检项目',securitycheckitemManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
