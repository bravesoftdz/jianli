unit InitManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses InitManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var initManagerExport:TInitManagerExport;
begin
  initManagerExport:=TInitManagerExport.Create;
  Reg.RegisterFunctionItem(initManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\���ܿ�����',initManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
