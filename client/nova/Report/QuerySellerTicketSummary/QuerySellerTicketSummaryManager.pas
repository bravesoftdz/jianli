unit QuerySellerTicketSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySellerTicketSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var QuerySellerTicketSummary:QuerySellerTicketSummaryItem;
  par:TFunctionItemParameters;

begin
  QuerySellerTicketSummary:=QuerySellerTicketSummaryItem.Create;
  Reg.RegisterFunctionItem(QuerySellerTicketSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('վ��ֹ�˾��ƱԱ��Ʊ������ܱ�',QuerySellerTicketSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
