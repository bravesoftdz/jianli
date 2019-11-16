unit BillinuseReportManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillinuseReportManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var billinuseReportManagerExport: TBillinuseReportManagerExport;
begin
  billinuseReportManagerExport:=TBillinuseReportManagerExport.Create;
  Reg.RegisterFunctionItem(billinuseReportManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('报表查询\售票员票证使用情况查询',billinuseReportManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
