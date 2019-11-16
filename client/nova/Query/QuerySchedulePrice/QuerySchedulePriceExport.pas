unit QuerySchedulePriceExport;
{ ------------------------------------
  功能说明：QueryschedulePrice.bpl输出单元
  创建日期：2011.07.13
  作者：hhz
  版权：nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;
implementation
uses QuerySchedulePricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  queryschedulePrice:querySchedulePriceManage;
begin
   //注册功能
  queryschedulePrice := querySchedulePriceManage.Create;
  Reg.RegisterFunctionItem(queryschedulePrice);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价查询\班次票价查询', queryschedulePrice.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
