{------------------------------------
  ����˵����Vehicleseatplan.bpl�����Ԫ
  �������ڣ�2011.2.22
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit VehicleseatplanExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses VehicleseatplanPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  vehiclespaceManager: TVehiclespaceManager;
  vehicleseatplanManager:TVehicleseatplanManager;
begin
  vehiclespaceManager := TVehiclespaceManager.Create;
  Reg.RegisterFunctionItem(vehiclespaceManager);
  vehicleseatplanManager:=TvehicleseatplanManager.Create;
  Reg.RegisterFunctionItem(vehicleseatplanManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('ҵ�����\�����ڲ��ռ����', vehiclespaceManager.key, nil);
    (SysService as IMainForm).CreateMenu('ҵ�����\������λͼ����', vehicleseatplanManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
