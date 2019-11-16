unit VipbooktimeManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VipbooktimePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var VipbooktimeMg:VipbooktimeMS;
begin
  VipbooktimeMg:= VipbooktimeMS.Create;
  Reg.RegisterFunctionItem(VipbooktimeMg);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ա��Ʊʱ������',VipbooktimeMg.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
