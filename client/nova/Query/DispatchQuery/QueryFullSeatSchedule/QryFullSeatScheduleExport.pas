unit QryFullSeatScheduleExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QryFullSeatSchedulePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var fullSeatSchedule:fullSeatScheduleManager;
  par:TFunctionItemParameters;

begin
  fullSeatSchedule:=fullSeatScheduleManager.Create;
  Reg.RegisterFunctionItem(fullSeatSchedule);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\������������ѯ',fullSeatSchedule.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
