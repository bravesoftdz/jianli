unit SecurityManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SecurityManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var securityManagerExport:TSecurityManagerExport;
    securitycheckReportManager:TSecurityReportManagerExport;
    securityFeeReportManagerExport:TSecurityFeeReportManagerExport;
begin
  securityManagerExport:=TSecurityManagerExport.Create;
  Reg.RegisterFunctionItem(securityManagerExport);

  securitycheckReportManager:=TSecurityReportManagerExport.Create;
  Reg.RegisterFunctionItem(securitycheckReportManager);

  securityFeeReportManagerExport:=TSecurityFeeReportManagerExport.Create;
  Reg.RegisterFunctionItem(securityFeeReportManagerExport);

{$IFDEF DEBUG}
 // (SysService as  IMainForm).CreateMenu('�������\��������',securityManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
