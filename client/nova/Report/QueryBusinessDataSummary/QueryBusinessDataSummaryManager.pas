unit QueryBusinessDataSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryBusinessDataSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var querysrouteDynamicCompare:routeDynamicCompareManager;
  par:TFunctionItemParameters;

begin
  querysrouteDynamicCompare:=routeDynamicCompareManager.Create;
  Reg.RegisterFunctionItem(querysrouteDynamicCompare);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('վ��ֹ�˾վ��ҵ������������ܱ�',querysrouteDynamicCompare.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
