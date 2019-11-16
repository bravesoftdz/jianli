unit VehicleStationDepartinvoiceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehicleStationDepartinvoiceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleStationDepartinvoiceManagerExport: TVehicleStationDepartinvoiceManagerExport;
begin
  vehicleStationDepartinvoiceManagerExport:=TVehicleStationDepartinvoiceManagerExport.Create;
  Reg.RegisterFunctionItem(vehicleStationDepartinvoiceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\����ͣ��վ������������ܱ�',vehicleStationDepartinvoiceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
