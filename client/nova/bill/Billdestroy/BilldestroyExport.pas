unit BilldestroyExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����

procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses BilldestroyPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  billdestroyPlugin: TBilldestroyPlugin;
  par: TFunctionItemParameters;

begin
  billdestroyPlugin := TBilldestroyPlugin.Create;
  Reg.RegisterFunctionItem(billdestroyPlugin);

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
