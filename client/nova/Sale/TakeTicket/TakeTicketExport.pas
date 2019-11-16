{------------------------------------
  功能说明：TakeTicket.bpl输出单元
  创建日期：2011.10.15
  作者：ice
  版权：nova
-------------------------------------}
unit TakeTicketExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TakeTicketPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  parameters:TFunctionItemParameters;
  printticket:TTakeTicketFunction;
begin
  printticket:=TTakeTicketFunction.Create;
  Reg.RegisterFunctionItem(printticket);
{$IFDEF DEBUG}
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('售票管理\电子票取票', printticket.key, parameters);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
