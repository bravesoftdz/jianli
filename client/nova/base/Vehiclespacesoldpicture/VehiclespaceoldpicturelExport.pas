unit VehiclespaceoldpicturelExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses VehiclespacesoldpicturePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  vehiclespacesoldpictureManager: TVehiclespacesoldpictureManager;
  i: integer;
begin
  vehiclespacesoldpictureManager := TVehiclespacesoldpictureManager.Create;
  Reg.RegisterFunctionItem(vehiclespacesoldpictureManager);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('业务管理\车辆座位空间售出图片', vehiclespacesoldpictureManager.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
