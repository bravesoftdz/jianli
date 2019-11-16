unit VehicleReportcStatusExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleReportStatusPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleReportStatus:vehicleReportStatusManager;
  par:TFunctionItemParameters;

begin
  vehicleReportStatus:=vehicleReportStatusManager.Create;
  Reg.RegisterFunctionItem(vehicleReportStatus);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�����������һ����',vehicleReportStatus.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
