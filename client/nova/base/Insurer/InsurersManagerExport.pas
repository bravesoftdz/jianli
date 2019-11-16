unit InsurersManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsurersManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var insurersManagerExport:TInsurersManagerExport;
begin
  insurersManagerExport:=TInsurersManagerExport.Create;
  Reg.RegisterFunctionItem(insurersManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\���չ�˾',insurersManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
