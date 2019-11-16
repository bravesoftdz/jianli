unit QueryVehicleLicenseExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses QueryVehicleLicensePlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  vehcielLicenseManager: TVehcielLicenseManager;
begin
  vehcielLicenseManager := TVehcielLicenseManager.Create;
  Reg.RegisterFunctionItem(vehcielLicenseManager);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
