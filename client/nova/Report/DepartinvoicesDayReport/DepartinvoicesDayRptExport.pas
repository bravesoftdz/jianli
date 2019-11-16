unit DepartinvoicesDayRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DepartinvoicesDayRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var departinvoicesDayRpt:DepartinvoicesDayRptManager;
  par:TFunctionItemParameters;

begin
  departinvoicesDayRpt:=DepartinvoicesDayRptManager.Create;
  Reg.RegisterFunctionItem(departinvoicesDayRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('������ʡ���ؿ�������ͳ�Ʊ�',departinvoicesDayRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
