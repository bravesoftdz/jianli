unit SchedulestationcontrolExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses SchedulestationcontrolPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var schedulestationcontrol:schedulestationcontrolMS;
  par:TFunctionItemParameters;

begin
  schedulestationcontrol:=schedulestationcontrolMS.Create;
  Reg.RegisterFunctionItem(schedulestationcontrol);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\���վ����Ʊ����',schedulestationcontrol.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
