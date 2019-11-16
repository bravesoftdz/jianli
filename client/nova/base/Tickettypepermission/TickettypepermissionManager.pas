unit TickettypepermissionManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TickettypepermissionPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var tickettypepermissionManager:TTickettypepermissionManager;
begin
  tickettypepermissionManager:=TTickettypepermissionManager.Create;
  Reg.RegisterFunctionItem(tickettypepermissionManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ���Ϳ���Ȩ�޿���',tickettypepermissionManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
