unit DeductRoutestopExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses DeductRoutestopPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var deductRoutestop:TDeductRoutestop;
begin
  deductRoutestop:=TDeductRoutestop.Create;
  Reg.RegisterFunctionItem(deductRoutestop);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\��·ͣ����۷�',deductRoutestop.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
