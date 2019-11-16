unit DepartinvoicedeductExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DepartinvoicedeductPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
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
  //(SysService as  IMainForm).CreateMenu('固定扣费项目表',departinvoicededuct.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
