unit DeductitemExport;

{ ------------------------------------
  功能说明：Deductitem.bpl输出单元
  创建日期：2011.06.03
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses DeductitemPlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  deductItemFunctionItem: TDeductItemFunctionItem;
begin
   //注册功能
  deductItemFunctionItem := TDeductItemFunctionItem.Create;
  Reg.RegisterFunctionItem(deductItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('结算管理\固定扣费项目管理', deductItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
