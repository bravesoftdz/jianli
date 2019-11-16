unit QueryBalanceitemManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryBalanceitemManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var balanceitemManagerExport:TBalanceitemManagerExport;
var qryTakeTicketLogManagerExport:TQryTakeTicketLogManagerExport;
begin
  balanceitemManagerExport:=TBalanceitemManagerExport.Create;
  Reg.RegisterFunctionItem(balanceitemManagerExport);
  qryTakeTicketLogManagerExport:=TQryTakeTicketLogManagerExport.Create;
  Reg.RegisterFunctionItem(qryTakeTicketLogManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\Ӫ�˽�����ϸ��',balanceitemManagerExport.key,nil);
  (SysService as  IMainForm).CreateMenu('ϵͳ����\ȡƱ��־��ѯ',qryTakeTicketLogManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
