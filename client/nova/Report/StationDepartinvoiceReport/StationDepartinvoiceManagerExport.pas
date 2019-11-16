unit StationDepartinvoiceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationDepartinvoiceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var stationDepartinvoiceManagerExport: TStationDepartinvoiceManagerExport;
begin
  stationDepartinvoiceManagerExport:=TStationDepartinvoiceManagerExport.Create;
  Reg.RegisterFunctionItem(stationDepartinvoiceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\ͣ��վ������������ܱ�',stationDepartinvoiceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
