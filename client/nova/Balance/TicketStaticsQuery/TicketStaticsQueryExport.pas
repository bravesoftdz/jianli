unit TicketStaticsQueryExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketStaticsQueryPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  staticsticket: TStaticsTicketFunction;
  parameters:TFunctionItemParameters;
begin
  staticsticket := TStaticsTicketFunction.Create;
  Reg.RegisterFunctionItem(staticsticket);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('财务管理\结算管理\营收统计查询', staticsticket.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
