unit ScheduleDiscountPriceManager;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation
uses ScheduleDiscountPricePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  scheduleDiscountPrice: TScheduleDiscountPrice;
begin
   //ע�Ṧ��
  scheduleDiscountPrice := TScheduleDiscountPrice.Create;
  Reg.RegisterFunctionItem(scheduleDiscountPrice);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('Ʊ�۹���\�Ż�Ʊ�۹���', scheduleDiscountPrice.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
