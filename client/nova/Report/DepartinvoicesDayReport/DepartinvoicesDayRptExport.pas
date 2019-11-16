unit DepartinvoicesDayRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DepartinvoicesDayRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var departinvoicesDayRpt:DepartinvoicesDayRptManager;
  par:TFunctionItemParameters;

begin
  departinvoicesDayRpt:=DepartinvoicesDayRptManager.Create;
  Reg.RegisterFunctionItem(departinvoicesDayRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('发往各省、地客运量日统计表',departinvoicesDayRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
