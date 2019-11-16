{------------------------------------
  功能说明：onecard.bpl输出单元
  创建日期：2012.12.06
  作者：ice
  版权：nova
-------------------------------------}
unit onecardExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
     onecardPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  parameters:TFunctionItemParameters;
  onecardfunction:TOneCardFunction;
  oneCardFunctionReturn:TOneCardFunctionReturn;
begin
  onecardfunction:=TOneCardFunction.Create;
  Reg.RegisterFunctionItem(onecardfunction);
  oneCardFunctionReturn:=TOneCardFunctionReturn.Create;
  Reg.RegisterFunctionItem(oneCardFunctionReturn);
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
