unit DepartinvoicesotherTicketnoExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses DepartinvoicesotherTicketnoPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var departinvoicesotherTicketnoExport:TDepartinvoicesotherTicketnoExport;

begin
  departinvoicesotherTicketnoExport:=TDepartinvoicesotherTicketnoExport.Create;
  Reg.RegisterFunctionItem(departinvoicesotherTicketnoExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\���㵥��¼',departinvoicesotherTicketnoExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
