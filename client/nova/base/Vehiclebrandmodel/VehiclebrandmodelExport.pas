unit VehiclebrandmodelExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses VehiclebrandmodelPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  vehiclebrandmodelManager: TVehiclebrandmodelManager;
  i: integer;
begin
  vehiclebrandmodelManager := TVehiclebrandmodelManager.Create;
  Reg.RegisterFunctionItem(vehiclebrandmodelManager);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('业务管理\车辆品牌型号管理', vehiclebrandmodelManager.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
