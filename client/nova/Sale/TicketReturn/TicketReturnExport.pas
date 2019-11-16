{------------------------------------
  功能说明：TicketReturn.bpl输出单元
  创建日期：2011.1.26
  作者：ice
  版权：nova
-------------------------------------}
unit TicketReturnExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketReturnPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  returnticket: TReturnTicketFunction;
  parameters:TFunctionItemParameters;
begin
  returnticket := TReturnTicketFunction.Create;
  Reg.RegisterFunctionItem(returnticket);

{$IFDEF DEBUG}
//  parameters:=TReturnTicketFunction.Create;
//  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('售票管理\退票', returnticket.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
