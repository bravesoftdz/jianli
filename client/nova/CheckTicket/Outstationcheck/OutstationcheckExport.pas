unit OutstationcheckExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
  procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

  exports PlugInit, PlugInFinal;

implementation

uses OutstationcheckPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  OutstationcheckExport: TOutstationcheckExport;
begin
  OutstationcheckExport := TOutstationcheckExport.Create;
  Reg.RegisterFunctionItem(OutstationcheckExport);

end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
