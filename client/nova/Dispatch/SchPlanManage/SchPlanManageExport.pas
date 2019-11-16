unit SchPlanManageExport;

{ ------------------------------------
  功能说明：SchPlanManage.bpl输出单元
  创建日期：2012.07.19
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses SchPlanManagePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  schPlanManageItemFunctionItem: TSchPlanManageItemFunctionItem;
begin
  // 注册功能
  schPlanManageItemFunctionItem := TSchPlanManageItemFunctionItem.Create;
  Reg.RegisterFunctionItem(schPlanManageItemFunctionItem);

end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
