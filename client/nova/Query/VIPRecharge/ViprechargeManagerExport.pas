unit ViprechargeManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses ViprechargeManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
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

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
