unit BillinuseBalanceReportExport;
{ ------------------------------------
  功能说明：BillinuseBalanceReport.bpl包插件对象
  创建日期：2011.12.03
  作者：ice
  版权：nova
  ------------------------------------- }

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses BillinuseBlanceReportPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  BillinuseBlanceReportItem: TBillinuseBlanceReportItem;
begin
   //注册功能
  BillinuseBlanceReportItem := TBillinuseBlanceReportItem.Create;
  Reg.RegisterFunctionItem(BillinuseBlanceReportItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('报表管理\票据报表\售票员销存报表', BillinuseBlanceReportItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
