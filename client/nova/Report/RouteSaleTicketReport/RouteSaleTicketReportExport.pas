unit RouteSaleTicketReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses RouteSaleTicketReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  routesaleticket:TRouteSaleTicket;
  par: TFunctionItemParameters;
begin
  routesaleticket:=TRouteSaleTicket.Create;
  Reg.RegisterFunctionItem(routesaleticket);

{$IFDEF DEBUG}
par := TFunctionItemParameters.Create; (SysService as IMainForm)
  .CreateMenu('����ͳ��\���񱨱�', routesaleticket.key, par);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
