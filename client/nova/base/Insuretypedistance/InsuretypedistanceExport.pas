unit InsuretypedistanceExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsuretypedistancePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var
  insuretypedistanceFunctionItem:TInsuretypedistanceFunctionItem;
  insuretypepriceFunctionItem :TInsuretypepriceFunctionItem;
begin
  insuretypedistanceFunctionItem:=TInsuretypedistanceFunctionItem.Create;
  Reg.RegisterFunctionItem(insuretypedistanceFunctionItem);
  insuretypepriceFunctionItem:=TInsuretypepriceFunctionItem.Create;
  Reg.RegisterFunctionItem(insuretypepriceFunctionItem);
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
