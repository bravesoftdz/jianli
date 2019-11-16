unit QueryTicketSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryTicketSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryTicketSummary:queryTicketSummaryItem;
  par:TFunctionItemParameters;

begin
  queryTicketSummary:=queryTicketSummaryItem.Create;
  Reg.RegisterFunctionItem(queryTicketSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('վ��ֹ�˾������Ʊ������ܱ�',queryTicketSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
