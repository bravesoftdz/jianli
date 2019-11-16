unit FocusTicketSaleQryExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FocusTicketSaleQryPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var focusSaleLocalManager:TFocusSaleLocalManager;
    focusSaleOtherManager:TFocusSaleOtherManager;
  par:TFunctionItemParameters;

begin
  focusSaleLocalManager:= TFocusSaleLocalManager.Create;
  Reg.RegisterFunctionItem(focusSaleLocalManager);
  focusSaleOtherManager := TFocusSaleOtherManager.Create;
  Reg.RegisterFunctionItem(focusSaleOtherManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\����ʽ��վ�۱�վ�����ѯ',focusSaleLocalManager.key,par);
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\����ʽ��վ����վ�����ѯ',focusSaleOtherManager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
