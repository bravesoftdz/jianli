unit RouteSaleTicketReportExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses RouteSaleTicketReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  routesaleticket:TRouteSaleTicket;
  par: TFunctionItemParameters;
begin
  routesaleticket:=TRouteSaleTicket.Create;
  Reg.RegisterFunctionItem(routesaleticket);

{$IFDEF DEBUG}
par := TFunctionItemParameters.Create; (SysService as IMainForm)
  .CreateMenu('报表统计\财务报表', routesaleticket.key, par);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
