unit QueryDrawVehSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDrawVehSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryDrawVehSummary:queryDrawVehSummaryItem;
  par:TFunctionItemParameters;

begin
  queryDrawVehSummary:=queryDrawVehSummaryItem.Create;
  Reg.RegisterFunctionItem(queryDrawVehSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('վ��ֹ�˾��վ�������ܱ�',queryDrawVehSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
