unit QueryCustomerBookingManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryCustomerBookingPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
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
  (SysService as  IMainForm).CreateMenu('��Ʊͳ�Ʋ�ѯ',querysrouteDynamicCompare.key,par);

  pa:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ԥ��������ܱ�',persell.key,par);


{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
