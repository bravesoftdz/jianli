unit SchPlanManageExport;

{ ------------------------------------
  ����˵����SchPlanManage.bpl�����Ԫ
  �������ڣ�2012.07.19
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses SchPlanManagePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  schPlanManageItemFunctionItem: TSchPlanManageItemFunctionItem;
begin
  // ע�Ṧ��
  schPlanManageItemFunctionItem := TSchPlanManageItemFunctionItem.Create;
  Reg.RegisterFunctionItem(schPlanManageItemFunctionItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
