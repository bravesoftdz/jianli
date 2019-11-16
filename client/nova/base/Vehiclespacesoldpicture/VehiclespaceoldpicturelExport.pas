unit VehiclespaceoldpicturelExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses VehiclespacesoldpicturePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  vehiclespacesoldpictureManager: TVehiclespacesoldpictureManager;
  i: integer;
begin
  vehiclespacesoldpictureManager := TVehiclespacesoldpictureManager.Create;
  Reg.RegisterFunctionItem(vehiclespacesoldpictureManager);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('ҵ�����\������λ�ռ��۳�ͼƬ', vehiclespacesoldpictureManager.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
