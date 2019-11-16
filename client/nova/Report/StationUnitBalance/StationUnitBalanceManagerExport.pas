unit StationUnitBalanceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationUnitBalanceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var StationUnitBalanceManagerExport: TStationUnitBalanceManagerPlugin;
begin
  StationUnitBalanceManagerExport:=TStationUnitBalanceManagerPlugin.Create;
  Reg.RegisterFunctionItem(StationUnitBalanceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��վ����Ӫ��λ�����',StationUnitBalanceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
