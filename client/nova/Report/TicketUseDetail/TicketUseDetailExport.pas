unit TicketUseDetailExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketUseDetailPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  TicketUseDetailFunctionitem: TTicketUseDetailFunction;
  parameters:TFunctionItemParameters;
begin
  TicketUseDetailFunctionitem := TTicketUseDetailFunction.Create;
  Reg.RegisterFunctionItem(TicketUseDetailFunctionitem);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('财务管理\票据报表\票种使用明细表', TicketUseDetailFunctionitem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
