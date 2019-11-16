unit VehicletypeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicletypeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicletypeManagerExport:TVehicletypeManagerExport;
begin
  vehicletypeManagerExport:=TVehicletypeManagerExport.Create;
  Reg.RegisterFunctionItem(vehicletypeManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\车型管理',vehicletypeManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
