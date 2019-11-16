{------------------------------------
  功能说明：TicketCancel.bpl输出单元
  创建日期：2011.1.26
  作者：ice
  版权：nova
-------------------------------------}
unit TicketCancelExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketCancelPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  cancelticket: TCancelTicketFunction;
  parameters:TFunctionItemParameters;
begin
  cancelticket := TCancelTicketFunction.Create;
  Reg.RegisterFunctionItem(cancelticket);

{$IFDEF DEBUG}
//  parameters:=TCancelTicketFunction.Create;
//  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('售票管理\废票', cancelticket.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
