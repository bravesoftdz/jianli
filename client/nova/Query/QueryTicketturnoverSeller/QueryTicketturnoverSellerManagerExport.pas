unit QueryTicketturnoverSellerManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryTicketturnoverSellerManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var sellerManagerExport:TQueryTicketturnoverSellerManagerExport;
begin
  sellerManagerExport:=TQueryTicketturnoverSellerManagerExport.Create;
  Reg.RegisterFunctionItem(sellerManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('综合查询\财务查询\售票员解款情况表',sellerManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
