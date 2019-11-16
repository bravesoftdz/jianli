unit QueryInsuranceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryInsuranceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var insuranceManagerExport:TInsuranceManagerExport;
    InsuranceExport:TInsuranceExport;
begin
  insuranceManagerExport:=TInsuranceManagerExport.Create;
  Reg.RegisterFunctionItem(insuranceManagerExport);
  InsuranceExport:=TInsuranceExport.Create;
  Reg.RegisterFunctionItem(InsuranceExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\�������������ѯ',insuranceManagerExport.key,nil);
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\�������ۻ��ܲ�ѯ',InsuranceExport.key,nil);
  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
