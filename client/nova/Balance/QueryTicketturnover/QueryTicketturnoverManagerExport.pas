unit QueryTicketturnoverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryTicketturnoverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryTicketturnoverManagerExport:TQueryTicketturnoverManagerExport;
begin
  queryTicketturnoverManagerExport:=TQueryTicketturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(queryTicketturnoverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('结算管理\售票员缴款查询',queryTicketturnoverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
