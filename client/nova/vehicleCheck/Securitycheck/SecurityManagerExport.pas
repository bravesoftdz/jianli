unit SecurityManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses SecurityManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
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
 // (SysService as  IMainForm).CreateMenu('°²¼ì¹ÜÀí\³µÁ¾°²¼ì',securityManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
