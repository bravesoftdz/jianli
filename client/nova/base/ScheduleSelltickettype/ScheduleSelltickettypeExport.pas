unit ScheduleSelltickettypeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleSelltickettypePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var selltickettype:selltickettypeMS;
  par:TFunctionItemParameters;

begin
  selltickettype:=selltickettypeMS.Create;
  Reg.RegisterFunctionItem(selltickettype);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\���Ԥ��Ʊ�ֿ���',selltickettype.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
