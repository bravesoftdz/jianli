unit QueryScheduleCheckSumExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryScheduleCheckSumPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var par:TFunctionItemParameters;
  qryScheduleCheckSum:TQryScheduleCheckSum;
begin
  qryScheduleCheckSum:=TQryScheduleCheckSum.create;
  Reg.RegisterFunctionItem(qryScheduleCheckSum);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\��μ�Ʊ���ܱ�',qryScheduleCheckSum.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
