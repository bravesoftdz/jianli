unit SchedulediscountManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SchedulediscountManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var schManagerExport:TSchedulediscountManagerExport;
begin
  schManagerExport:=TSchedulediscountManagerExport.Create;
  Reg.RegisterFunctionItem(schManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\����ۿ۹���',schManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
