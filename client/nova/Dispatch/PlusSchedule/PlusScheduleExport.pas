unit PlusScheduleExport;

{ ------------------------------------
  ����˵����PlusSchedule.bpl�����Ԫ
  �������ڣ�2011.07.09
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses PlusSchedulePlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  plusScheduleItemFunctionItem: TPlusScheduleItemFunctionItem;
begin
   //ע�Ṧ��
  plusScheduleItemFunctionItem := TPlusScheduleItemFunctionItem.Create;
  Reg.RegisterFunctionItem(plusScheduleItemFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('���ȹ���\�Ӱ����', plusScheduleItemFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
