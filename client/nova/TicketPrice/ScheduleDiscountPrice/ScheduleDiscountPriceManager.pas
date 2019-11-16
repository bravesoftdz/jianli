unit ScheduleDiscountPriceManager;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation
uses ScheduleDiscountPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  scheduleDiscountPrice: TScheduleDiscountPrice;
begin
   //注册功能
  scheduleDiscountPrice := TScheduleDiscountPrice.Create;
  Reg.RegisterFunctionItem(scheduleDiscountPrice);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('票价管理\优惠票价管理', scheduleDiscountPrice.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization
end.
