unit VehiclebrandmodelExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses VehiclebrandmodelPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  vehiclebrandmodelManager: TVehiclebrandmodelManager;
  i: integer;
begin
  vehiclebrandmodelManager := TVehiclebrandmodelManager.Create;
  Reg.RegisterFunctionItem(vehiclebrandmodelManager);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('ҵ�����\����Ʒ���ͺŹ���', vehiclebrandmodelManager.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
