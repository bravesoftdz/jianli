unit OperationlogExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses OperationlogPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
//var paramManager:TparamManager;
var Operationlog:TOperationManager;

begin
  Operationlog:=TOperationManager.Create;
  Reg.RegisterFunctionItem(Operationlog);

{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ϵͳ����\������־��ѯ',Operationlog.key,nil);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
