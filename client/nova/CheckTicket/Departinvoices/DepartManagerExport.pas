unit DepartManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses DepartManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var
  departinvoicesManagerExport:TDepartinvoicesManagerExport;
  departinvoicesJcExport:TDepartinvoicesJcExport;
begin
  departinvoicesManagerExport:=TDepartinvoicesManagerExport.Create;
  Reg.RegisterFunctionItem(departinvoicesManagerExport);

  departinvoicesJcExport:=TDepartinvoicesJcExport.Create;
  Reg.RegisterFunctionItem(departinvoicesJcExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\结算单管理',departinvoicesManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
