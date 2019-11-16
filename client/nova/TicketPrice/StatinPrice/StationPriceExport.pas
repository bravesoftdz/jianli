unit StationPriceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses StationPricePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var stationprice:StationpriceManager;
  par:TFunctionItemParameters;

begin
  stationprice:=StationpriceManager.Create;
  Reg.RegisterFunctionItem(stationprice);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('Ʊ�۹���\վ��ƽʱƱ�۹���',stationprice.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
