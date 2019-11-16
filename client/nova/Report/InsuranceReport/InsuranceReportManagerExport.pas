unit InsuranceReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsuranceReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var insuranceReportManagerExport:TInsuranceReportManagerExport;
begin
  insuranceReportManagerExport:=TInsuranceReportManagerExport.Create;
  Reg.RegisterFunctionItem(insuranceReportManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('售票报表\售票员保险销售统计',insuranceReportManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
