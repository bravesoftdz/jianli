unit OrgManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses OrgManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var orgManagerExport:TOrgManagerExport;
begin
  orgManagerExport:=TOrgManagerExport.Create;
  Reg.RegisterFunctionItem(orgManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('系统管理\组织机构',orgManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
