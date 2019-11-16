unit QueryDepartinvoicesExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDepartinvoicesPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var queryDepartinvoices:queryDepartinvoicesMG;
  par:TFunctionItemParameters;
  qryDepartinvoinceschedule:TQryDepartinvoinceschedule;
begin
  queryDepartinvoices:=queryDepartinvoicesMG.Create;
  Reg.RegisterFunctionItem(queryDepartinvoices);
  qryDepartinvoinceschedule:=TQryDepartinvoinceschedule.create;
  Reg.RegisterFunctionItem(qryDepartinvoinceschedule);
{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('检票查询\班次结算情况查询',queryDepartinvoices.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
