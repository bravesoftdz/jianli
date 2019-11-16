unit VipremainmoneyManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VipremainmoneyManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var vipremainmoneyManagerExport:TVipremainmoneyExport;
begin
  vipremainmoneyManagerExport:=TVipremainmoneyExport.Create;
  Reg.RegisterFunctionItem(vipremainmoneyManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\VIP������ϸ��ѯ',vipremainmoneyManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
