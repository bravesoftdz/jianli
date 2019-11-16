unit QueryCustomerBookingManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryCustomerBookingPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querysrouteDynamicCompare:routeDynamicCompareManager;
    persell:PersellSum;
  par:TFunctionItemParameters;
  pa:TFunctionItemParameters;
begin
  querysrouteDynamicCompare:=routeDynamicCompareManager.Create;
  Reg.RegisterFunctionItem(querysrouteDynamicCompare);
  persell:= PersellSum.Create;
  Reg.RegisterFunctionItem(persell);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('订票统计查询',querysrouteDynamicCompare.key,par);

  pa:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('班次预售情况汇总表',persell.key,par);


{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
