unit ScheduleExport;

{ ------------------------------------
  ����˵����schedule.bpl�����Ԫ
  �������ڣ�2011.01.28
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses SchedulePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  scheduleFunctionItem: TScheduleFunctionItem;
begin
   //ע�Ṧ��
  scheduleFunctionItem := TScheduleFunctionItem.Create;
  Reg.RegisterFunctionItem(scheduleFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('ҵ�����\��ι���', scheduleFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
