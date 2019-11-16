unit StationRouteReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationRouteReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var stationRManagerExport: TStationRouteReportManagerExport;
begin
  stationRManagerExport:=TStationRouteReportManagerExport.Create;
  Reg.RegisterFunctionItem(stationRManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�����ѯ\���˰��ߵ���ͳ�Ʊ�',stationRManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
