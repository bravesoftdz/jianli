unit VipturnoverManagerExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VipTurnoverManagerPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var vipTurnover:VipturnoverManager;
  par:TFunctionItemParameters;

begin
  vipTurnover:=VipturnoverManager.Create;
  Reg.RegisterFunctionItem(vipTurnover);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('VIP�ɿ�',vipTurnover.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
