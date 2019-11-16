unit UpgradelogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses UpgradelogePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var upl:Upgradelog;
  par:TFunctionItemParameters;

begin
  upl:=upgradelog.Create;
  Reg.RegisterFunctionItem(upl);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ϵͳ����\ϵͳ������־',upl.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
