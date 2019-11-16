unit QueryTicketreprintExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryTicketreprintPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var QueryTicketreprintExport: TQueryTicketreprintExport;
begin
  QueryTicketreprintExport:=TQueryTicketreprintExport.Create;
  Reg.RegisterFunctionItem(QueryTicketreprintExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\车票换号重打查询',QueryTicketreprintExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
