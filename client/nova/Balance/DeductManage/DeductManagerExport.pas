unit DeductManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses DeductManagePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var deductManager:TDeductManager;
begin
  deductManager:=TDeductManager.Create;
  Reg.RegisterFunctionItem(deductManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\�۷ѹ���',deductManager.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
