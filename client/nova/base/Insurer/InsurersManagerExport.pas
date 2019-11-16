unit InsurersManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsurersManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var insurersManagerExport:TInsurersManagerExport;
begin
  insurersManagerExport:=TInsurersManagerExport.Create;
  Reg.RegisterFunctionItem(insurersManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\保险公司',insurersManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
