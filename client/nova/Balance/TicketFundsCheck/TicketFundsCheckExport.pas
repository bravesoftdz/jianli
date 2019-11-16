unit TicketFundsCheckExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses TicketFundsCheckPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  TicketFundsCheck:TTicketFundsCheck;
  par: TFunctionItemParameters;
begin
  TicketFundsCheck:=TTicketFundsCheck.Create;
  Reg.RegisterFunctionItem(TicketFundsCheck);

{$IFDEF DEBUG}
par := TFunctionItemParameters.Create; (SysService as IMainForm)
  .CreateMenu('结算管理\票款对付表', TicketFundsCheck.key, par);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
