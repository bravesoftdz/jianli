unit OutstationcheckExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
  procedure PlugInFinal(); // ж�ز��

  exports PlugInit, PlugInFinal;

implementation

uses OutstationcheckPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  OutstationcheckExport: TOutstationcheckExport;
begin
  OutstationcheckExport := TOutstationcheckExport.Create;
  Reg.RegisterFunctionItem(OutstationcheckExport);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
