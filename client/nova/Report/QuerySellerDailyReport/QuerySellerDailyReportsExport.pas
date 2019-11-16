unit QuerySellerDailyReportsExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySellerDailyReportPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querysellerReport:dailyReportManager;
  par:TFunctionItemParameters;

begin
  querysellerReport:=dailyReportManager.Create;
  Reg.RegisterFunctionItem(querysellerReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务人员\售票员营收情况日报表',querysellerReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
