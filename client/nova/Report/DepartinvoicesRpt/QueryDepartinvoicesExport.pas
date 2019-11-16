unit QueryDepartinvoicesExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDepartinvoicesPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
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
  (SysService as  IMainForm).CreateMenu('��Ʊ��ѯ\��ν��������ѯ',queryDepartinvoices.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
