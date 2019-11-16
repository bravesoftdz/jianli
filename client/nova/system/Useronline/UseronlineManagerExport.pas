unit UseronlineManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses UseronlineManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var useronlineManagerExport:TUseronlineManagerExport;
begin
  useronlineManagerExport:=TUseronlineManagerExport.Create;
  Reg.RegisterFunctionItem(useronlineManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ϵͳ����\�û����߹���',useronlineManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
