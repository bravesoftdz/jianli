unit DeductitemApplyExport;


{ ------------------------------------
  ����˵����DeductitemApply.bpl�����Ԫ
  �������ڣ�2011.06.08
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses DeductitemApplyPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  deductItemApplyFunctionItem: TDeductItemApplyFunctionItem;
begin
   //ע�Ṧ��
  deductItemApplyFunctionItem := TDeductItemApplyFunctionItem.Create;
  Reg.RegisterFunctionItem(deductItemApplyFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�������\�̶��۷���ĿӦ��', deductItemApplyFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
