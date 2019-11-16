unit QueryOrgDataSummaryManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryOrgDataSummaryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryOrgDataSummary:QueryOrgDataSummaryItem;
  par:TFunctionItemParameters;

begin
  QueryOrgDataSummary:=QueryOrgDataSummaryItem.Create;
  Reg.RegisterFunctionItem(QueryOrgDataSummary);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('վ����ҵͳ�Ʊ���',QueryOrgDataSummary.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
