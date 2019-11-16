unit DeductitemApplyExport;


{ ------------------------------------
  功能说明：DeductitemApply.bpl输出单元
  创建日期：2011.06.08
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses DeductitemApplyPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  deductItemApplyFunctionItem: TDeductItemApplyFunctionItem;
begin
   //注册功能
  deductItemApplyFunctionItem := TDeductItemApplyFunctionItem.Create;
  Reg.RegisterFunctionItem(deductItemApplyFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('结算管理\固定扣费项目应用', deductItemApplyFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
