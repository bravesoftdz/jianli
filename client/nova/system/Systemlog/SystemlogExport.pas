unit SystemlogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses SystemlogPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
//var paramManager:TparamManager;
var logFind:TLogManager;

begin
  logFind:=TLogManager.Create;
  Reg.RegisterFunctionItem(logFind);

{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ϵͳ����\������־��ѯ',logFind.key,nil);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
