{------------------------------------
  功能说明：NovaTakeTicket.bpl输出单元
  创建日期：2011.10.15
  作者：ice
  版权：nova
-------------------------------------}
unit NovaTakeTicketExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  NovaTakeTicketPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  parameters:TFunctionItemParameters;
  printticket:TNovaTakeTicketFunction;
begin
  printticket:=TNovaTakeTicketFunction.Create;
  Reg.RegisterFunctionItem(printticket);
{$IFDEF DEBUG}
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('售票管理\Nova电子票取票', printticket.key, parameters);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
