unit SelfDepartinvoicesExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

uses SelfDepartinvoicesPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  selfDepartinvoicesItem: TSelfDepartinvoicesItem;
begin
  // ×¢²á¹¦ÄÜ
  selfDepartinvoicesItem := TSelfDepartinvoicesItem.Create;
  Reg.RegisterFunctionItem(selfDepartinvoicesItem);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
