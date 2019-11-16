{------------------------------------
  功能说明：ViewSchedulestops.bpl输出单元
  创建日期：2011.8.27
  作者：ice
  版权：nova
-------------------------------------}
unit ViewSchedulestopsExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  ViewSchedulestopsPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  returnticket: TViewSchedulestopsFunction;
  parameters:TFunctionItemParameters;
begin
  returnticket := TViewSchedulestopsFunction.Create;
  Reg.RegisterFunctionItem(returnticket);
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
