unit DistrictManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses DistrictPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var districtManager:TDistrictManager;
begin
  districtManager:=TDistrictManager.Create;
  Reg.RegisterFunctionItem(districtManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\�������',districtManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
