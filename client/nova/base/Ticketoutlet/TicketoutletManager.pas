{------------------------------------
  ����˵����tickettype.bpl�����Ԫ
  �������ڣ�2011/01/22
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit TicketoutletManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketoutletFunctionItem: TTicketoutletFunctionItem;
begin
 ticketoutletFunctionItem:=TTicketoutletFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketoutletFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ�����',ticketoutletFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
