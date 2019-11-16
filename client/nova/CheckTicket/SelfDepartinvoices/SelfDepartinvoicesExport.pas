unit SelfDepartinvoicesExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses SelfDepartinvoicesPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  selfDepartinvoicesItem: TSelfDepartinvoicesItem;
begin
  // ע�Ṧ��
  selfDepartinvoicesItem := TSelfDepartinvoicesItem.Create;
  Reg.RegisterFunctionItem(selfDepartinvoicesItem);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
