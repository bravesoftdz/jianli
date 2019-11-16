unit QueryInsuranceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryInsuranceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var insuranceManagerExport:TInsuranceManagerExport;
    InsuranceExport:TInsuranceExport;
begin
  insuranceManagerExport:=TInsuranceManagerExport.Create;
  Reg.RegisterFunctionItem(insuranceManagerExport);
  InsuranceExport:=TInsuranceExport.Create;
  Reg.RegisterFunctionItem(InsuranceExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('售票查询\保险销售情况查询',insuranceManagerExport.key,nil);
  (SysService as  IMainForm).CreateMenu('售票查询\保险销售汇总查询',InsuranceExport.key,nil);
  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
