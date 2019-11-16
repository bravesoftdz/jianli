unit TicketSaleQryExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketSaleQryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketSaleQry:ticketSaleQryManager;
    salelcoa:SaleLocalManager;
    saleother:SaleOtherManager;
    presell:PresellManager;
    ticketchange:ticketchangeManager;
    reserveTicket:reserveTicketManager;
    ticketReturn:ticketReturnManager;
    ticketCancle:ticketCancleManager;
    queryBilldamage:queryBilldamagedManager ;
    returnlocal:returnLocalManager;
  par:TFunctionItemParameters;

begin
  ticketSaleQry:=ticketSaleQryManager.Create;
  Reg.RegisterFunctionItem(ticketSaleQry);
  salelcoa := SaleLocalManager.Create;
  Reg.RegisterFunctionItem(salelcoa);
  saleother:=SaleOtherManager.Create;
  Reg.RegisterFunctionItem(saleother);
  presell:=PresellManager.Create;
  Reg.RegisterFunctionItem(presell);
  ticketchange:= ticketchangeManager.Create;
  Reg.RegisterFunctionItem(ticketchange);
  reserveTicket:= reserveTicketManager.Create;
  Reg.RegisterFunctionItem(reserveTicket);
  ticketReturn:= ticketReturnManager.Create;
  Reg.RegisterFunctionItem(ticketReturn);
  ticketCancle:= ticketCancleManager.Create;
  Reg.RegisterFunctionItem(ticketCancle);
  queryBilldamage:= queryBilldamagedManager.Create;
  Reg.RegisterFunctionItem(queryBilldamage);
  returnlocal:= returnLocalManager.Create;
  Reg.RegisterFunctionItem(returnlocal);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ�����ѯ',ticketSaleQry.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��վ�۱�վ�����ѯ',salelcoa.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��վ����վ�����ѯ',saleother.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\Ԥ��Ʊ�����ѯ',presell.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��ǩ�����ѯ',ticketchange.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ�����ѯ',reserveTicket.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��վ��Ʊ�����ѯ',ticketReturn.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ�����ѯ',ticketCancle.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ�Ǽ������ѯ',queryBilldamage.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��վ�˱�վƱ��ѯ',returnlocal.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
