unit InsuretypedistanceExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsuretypedistancePlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var
  insuretypedistanceFunctionItem:TInsuretypedistanceFunctionItem;
  insuretypepriceFunctionItem :TInsuretypepriceFunctionItem;
begin
  insuretypedistanceFunctionItem:=TInsuretypedistanceFunctionItem.Create;
  Reg.RegisterFunctionItem(insuretypedistanceFunctionItem);
  insuretypepriceFunctionItem:=TInsuretypepriceFunctionItem.Create;
  Reg.RegisterFunctionItem(insuretypepriceFunctionItem);
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
