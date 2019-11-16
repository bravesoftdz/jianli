unit DepartinvoicedeductExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DepartinvoicedeductPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var departinvoicededuct:departinvoicedeductManager;
    vehicleDepartinvoice : vehicleDepartinvoiceManager;
    departinvoice : departinvoiceManager;
  //par:TFunctionItemParameters;

begin
  departinvoicededuct:=departinvoicedeductManager.Create;
  Reg.RegisterFunctionItem(departinvoicededuct);

  vehicleDepartinvoice:=vehicleDepartinvoiceManager.Create;
  Reg.RegisterFunctionItem(vehicleDepartinvoice);

  departinvoice:=departinvoiceManager.Create;
  Reg.RegisterFunctionItem(departinvoice);
{$IFDEF DEBUG}
  //par:=TFunctionItemParameters.Create;
  //(SysService as  IMainForm).CreateMenu('�̶��۷���Ŀ��',departinvoicededuct.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
