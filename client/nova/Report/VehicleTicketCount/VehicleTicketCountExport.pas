unit VehicleTicketCountExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleTicketCountPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleTicketCount:VehicleTicketCountManager;
  par:TFunctionItemParameters;

begin
  vehicleTicketCount:=VehicleTicketCountManager.Create;
  Reg.RegisterFunctionItem(vehicleTicketCount);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('������Ʊ����ͳ��',vehicleTicketCount.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
