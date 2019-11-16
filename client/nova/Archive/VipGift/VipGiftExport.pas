unit VipGiftExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����

procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VipGiftPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var vipgift:VipGiftManager;
  par:TFunctionItemParameters;

begin
  vipgift:=VipGiftManager.Create;
  Reg.RegisterFunctionItem(vipgift);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\��Ա��Ʒ����',vipgift.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
