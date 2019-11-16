unit DispatchManageExport;
{ ------------------------------------
  功能说明：DispatchManage.bpl输出单元
  创建日期：2011.05.6
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses DispatchManagePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  dispatchManageItemFunctionItem: TDispatchManageItemFunctionItem;
begin
   //注册功能
  dispatchManageItemFunctionItem := TDispatchManageItemFunctionItem.Create;
  Reg.RegisterFunctionItem(dispatchManageItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('调度管理\综合调度', dispatchManageItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
