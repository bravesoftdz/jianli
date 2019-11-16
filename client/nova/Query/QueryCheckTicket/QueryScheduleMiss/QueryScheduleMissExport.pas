unit QueryScheduleMissExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryScheduleMissPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryScheduleMiss:queryScheduleMissManager;
  par:TFunctionItemParameters;

begin
  queryScheduleMiss:=queryScheduleMissManager.Create;
  Reg.RegisterFunctionItem(queryScheduleMiss);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\���©�������ѯ',queryScheduleMiss.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
