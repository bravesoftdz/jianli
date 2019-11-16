unit QueryVehicleReportExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryVehicleReport:queryVehicleReportManager;
  par:TFunctionItemParameters;

begin
  queryVehicleReport:=queryVehicleReportManager.Create;
  Reg.RegisterFunctionItem(queryVehicleReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\��α��������ѯ',queryVehicleReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
