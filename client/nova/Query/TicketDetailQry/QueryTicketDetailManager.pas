unit QueryTicketDetailManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryTicketDetailPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryTicketDetail:queryTicketDetailItem;
  par:TFunctionItemParameters;

begin
  queryTicketDetail:=queryTicketDetailItem.Create;
  Reg.RegisterFunctionItem(queryTicketDetail);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('����Ʊ��ϸ��ѯ',queryTicketDetail.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
