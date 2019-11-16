unit VehicleStowageReportcExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleStowageReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleStowageReport:vehicleStowageReportManager;
  par:TFunctionItemParameters;

begin
  vehicleStowageReport:=vehicleStowageReportManager.Create;
  Reg.RegisterFunctionItem(vehicleStowageReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('����Ӫ������ͳ�Ʊ�',vehicleStowageReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
