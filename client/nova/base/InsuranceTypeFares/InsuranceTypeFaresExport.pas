unit InsuranceTypeFaresExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses InsuranceTypeFaresPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  FrmInsuranceTypeFaresItems:TFrmInsuranceTypeFaresItems;
begin
   //注册功能
  FrmInsuranceTypeFaresItems := TFrmInsuranceTypeFaresItems.Create;
  Reg.RegisterFunctionItem(FrmInsuranceTypeFaresItems);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('档案管理\保险类型票价', FrmInsuranceTypeFaresItems.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
initialization

finalization

end.
