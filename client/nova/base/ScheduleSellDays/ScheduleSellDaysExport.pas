unit ScheduleSellDaysExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleSellDaysPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var ScheduleSellDays:ScheduleSellDaysMS;
  par:TFunctionItemParameters;

begin
  ScheduleSellDays:=ScheduleSellDaysMS.Create;
  Reg.RegisterFunctionItem(ScheduleSellDays);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\���Ԥ����������',ScheduleSellDays.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
