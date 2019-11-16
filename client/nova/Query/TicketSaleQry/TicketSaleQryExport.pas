unit TicketSaleQryExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketSaleQryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
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
  (SysService as  IMainForm).CreateMenu('综合查询\售票情况查询',ticketSaleQry.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\异站售本站情况查询',salelcoa.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\本站售异站情况查询',saleother.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\预售票情况查询',presell.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\改签情况查询',ticketchange.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\留票情况查询',reserveTicket.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\本站退票情况查询',ticketReturn.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\废票情况查询',ticketCancle.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\坏票登记情况查询',queryBilldamage.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\异站退本站票查询',returnlocal.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
