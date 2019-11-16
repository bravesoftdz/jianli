unit QueryTicketreprintExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryTicketreprintPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryTicketreprintExport: TQueryTicketreprintExport;
begin
  QueryTicketreprintExport:=TQueryTicketreprintExport.Create;
  Reg.RegisterFunctionItem(QueryTicketreprintExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\��Ʊ�����ش��ѯ',QueryTicketreprintExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
