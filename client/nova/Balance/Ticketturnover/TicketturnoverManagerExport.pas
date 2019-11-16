unit TicketturnoverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketturnoverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var ticketturnoverManagerExport:TTicketturnoverManagerExport;
begin
  ticketturnoverManagerExport:=TTicketturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(ticketturnoverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\��ƱԱӪ�սɿ�',ticketturnoverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
