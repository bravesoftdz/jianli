unit QueryVehicleLicenseExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses QueryVehicleLicensePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  vehcielLicenseManager: TVehcielLicenseManager;
begin
  vehcielLicenseManager := TVehcielLicenseManager.Create;
  Reg.RegisterFunctionItem(vehcielLicenseManager);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
