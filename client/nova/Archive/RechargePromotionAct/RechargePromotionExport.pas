unit RechargePromotionExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件

procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses RechargePromotionPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var rechargePromotion:RechargePromotionManager;
  par:TFunctionItemParameters;

begin
  rechargePromotion:=RechargePromotionManager.Create;
  Reg.RegisterFunctionItem(rechargePromotion);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\充值优惠活动管理',rechargePromotion.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
