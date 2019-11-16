unit QuerySchedulemergeExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySchedulemergePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var querySchedulemerge:querySchedulemergeManager;
  par:TFunctionItemParameters;

begin
  querySchedulemerge:=querySchedulemergeManager.Create;
  Reg.RegisterFunctionItem(querySchedulemerge);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\���������ѯ',querySchedulemerge.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
