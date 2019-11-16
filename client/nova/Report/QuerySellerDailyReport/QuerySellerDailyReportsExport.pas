unit QuerySellerDailyReportsExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySellerDailyReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var querysellerReport:dailyReportManager;
  par:TFunctionItemParameters;

begin
  querysellerReport:=dailyReportManager.Create;
  Reg.RegisterFunctionItem(querysellerReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('������Ա\��ƱԱӪ������ձ���',querysellerReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
