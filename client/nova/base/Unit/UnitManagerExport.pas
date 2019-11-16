unit UnitManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses UnitManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var unitManagerExport:TUnitManagerExport;
begin
  unitManagerExport:=TUnitManagerExport.Create;
  Reg.RegisterFunctionItem(unitManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\������λ',unitManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
