unit CardissueManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses CardissueManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var cardissueManagerExport:TCardissueManagerExport;
begin
  cardissueManagerExport:=TCardissueManagerExport.Create;
  Reg.RegisterFunctionItem(cardissueManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\发卡记录',cardissueManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
