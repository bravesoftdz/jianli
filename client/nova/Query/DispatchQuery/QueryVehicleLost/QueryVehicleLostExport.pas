unit QueryVehicleLostExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryVehicleLostPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryVehicleLost:queryVehicleLostManager;
  par:TFunctionItemParameters;

begin
  queryVehicleLost:=queryVehicleLostManager.Create;
  Reg.RegisterFunctionItem(queryVehicleLost);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\�Ѱ��������ѯ',queryVehicleLost.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
