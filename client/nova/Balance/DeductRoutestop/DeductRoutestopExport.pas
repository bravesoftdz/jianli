unit DeductRoutestopExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses DeductRoutestopPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var deductRoutestop:TDeductRoutestop;
begin
  deductRoutestop:=TDeductRoutestop.Create;
  Reg.RegisterFunctionItem(deductRoutestop);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\线路停靠点扣费',deductRoutestop.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
