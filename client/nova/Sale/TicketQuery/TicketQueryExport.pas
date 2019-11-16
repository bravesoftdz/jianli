{------------------------------------
  功能说明：TicketQuery.bpl输出单元
  创建日期：2011.6.29
  作者：ice
  版权：nova
-------------------------------------}
unit TicketQueryExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketQueryPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  TicketQuery: TTicketQueryFunction;
begin
  TicketQuery := TTicketQueryFunction.Create;
  Reg.RegisterFunctionItem(TicketQuery);
{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('售票管理\售票问询', TicketQuery.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
