unit ScheduleCycleExport;

{ ------------------------------------
  ����˵����schedulecycle.bpl�����Ԫ
  �������ڣ�2011.03.03
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses ScheduleCyclePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  scheduleCycleFunctionItem: TScheduleCycleFunctionItem;
begin
   //ע�Ṧ��
  scheduleCycleFunctionItem := TScheduleCycleFunctionItem.Create;
  Reg.RegisterFunctionItem(scheduleCycleFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('ҵ�����\���ѭ������', scheduleCycleFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
