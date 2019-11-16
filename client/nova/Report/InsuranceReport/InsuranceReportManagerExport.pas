unit InsuranceReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsuranceReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var insuranceReportManagerExport:TInsuranceReportManagerExport;
begin
  insuranceReportManagerExport:=TInsuranceReportManagerExport.Create;
  Reg.RegisterFunctionItem(insuranceReportManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ����\��ƱԱ��������ͳ��',insuranceReportManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
