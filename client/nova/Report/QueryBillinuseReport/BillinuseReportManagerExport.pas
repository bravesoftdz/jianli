unit BillinuseReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillinuseReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var billinuseReportManagerExport: TBillinuseReportManagerExport;
begin
  billinuseReportManagerExport:=TBillinuseReportManagerExport.Create;
  Reg.RegisterFunctionItem(billinuseReportManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\��ƱԱƱ֤ʹ�������ѯ',billinuseReportManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
