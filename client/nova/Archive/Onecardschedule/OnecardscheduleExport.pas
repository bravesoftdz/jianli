unit OnecardscheduleExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses OnecardschedulePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var onecardschedule:onecardscheduleMS;
  par:TFunctionItemParameters;

begin
  onecardschedule:=onecardscheduleMS.Create;
  Reg.RegisterFunctionItem(onecardschedule);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\һ��ͨ�����ο���',onecardschedule.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
