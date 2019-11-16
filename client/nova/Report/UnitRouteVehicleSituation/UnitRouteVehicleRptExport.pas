unit UnitRouteVehicleRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses UnitRouteVehicleRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var rpt:unitRouteVehicleRptManager;
  par:TFunctionItemParameters;

begin
  rpt:=unitRouteVehicleRptManager.Create;
  Reg.RegisterFunctionItem(rpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������ͳ�Ʊ�',rpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
