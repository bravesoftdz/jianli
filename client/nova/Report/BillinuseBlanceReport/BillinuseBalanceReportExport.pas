unit BillinuseBalanceReportExport;
{ ------------------------------------
  ����˵����BillinuseBalanceReport.bpl���������
  �������ڣ�2011.12.03
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses BillinuseBlanceReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  BillinuseBlanceReportItem: TBillinuseBlanceReportItem;
begin
   //ע�Ṧ��
  BillinuseBlanceReportItem := TBillinuseBlanceReportItem.Create;
  Reg.RegisterFunctionItem(BillinuseBlanceReportItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('�������\Ʊ�ݱ���\��ƱԱ���汨��', BillinuseBlanceReportItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
