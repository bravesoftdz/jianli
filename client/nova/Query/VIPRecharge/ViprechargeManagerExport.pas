unit ViprechargeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses ViprechargeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var vipRechargeManagerExport:TViprechargeManagerExport;
    vipConsumeManager:TVipconsumeManagerExport;
    vipSellticketManager:TVipsellticketManagerExport;
    vipcardturnoverManager:TVipcardturnoverManagerExport;
begin
  vipRechargeManagerExport:=TViprechargeManagerExport.Create;
  Reg.RegisterFunctionItem(vipRechargeManagerExport);

  vipConsumeManager:=TVipconsumeManagerExport.Create;
  Reg.RegisterFunctionItem(vipConsumeManager);

  vipSellticketManager:=TVipsellticketManagerExport.Create;
  Reg.RegisterFunctionItem(vipSellticketManager);

  vipcardturnoverManager:=TVipcardturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(vipcardturnoverManager);
{$IFDEF DEBUG}
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
