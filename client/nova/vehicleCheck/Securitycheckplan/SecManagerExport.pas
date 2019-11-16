unit SecManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses SecManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var secManagerExport:TSecManagerExport;
begin
  secManagerExport:=TSecManagerExport.Create;
  Reg.RegisterFunctionItem(secManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('安检管理\安检计划',secManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
