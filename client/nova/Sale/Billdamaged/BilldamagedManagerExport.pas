unit BilldamagedManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BilldamagedManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var billdamagedManagerExport:TBilldamagedManagerExport;
begin
  billdamagedManagerExport:=TBilldamagedManagerExport.Create;
  Reg.RegisterFunctionItem(billdamagedManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ����\��Ʊ�Ǽ�',billdamagedManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
