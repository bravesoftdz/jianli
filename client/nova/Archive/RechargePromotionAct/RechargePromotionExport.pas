unit RechargePromotionExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����

procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses RechargePromotionPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var rechargePromotion:RechargePromotionManager;
  par:TFunctionItemParameters;

begin
  rechargePromotion:=RechargePromotionManager.Create;
  Reg.RegisterFunctionItem(rechargePromotion);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\��ֵ�Żݻ����',rechargePromotion.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
