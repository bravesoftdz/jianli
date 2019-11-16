{------------------------------------
  功能说明：InsureSale.bpl输出单元
  创建日期：2011.7.4
  作者：ice
  版权：nova
-------------------------------------}
unit InsureSaleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  InsureSalePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  InsureSale: TInsureSaleFunction;
  parameters:TFunctionItemParameters;
begin
  InsureSale := TInsureSaleFunction.Create;
  Reg.RegisterFunctionItem(InsureSale);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('售票管理\补售保险', InsureSale.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
