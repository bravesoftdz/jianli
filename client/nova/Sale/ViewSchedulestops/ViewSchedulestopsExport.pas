{------------------------------------
  ����˵����ViewSchedulestops.bpl�����Ԫ
  �������ڣ�2011.8.27
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit ViewSchedulestopsExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  ViewSchedulestopsPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  returnticket: TViewSchedulestopsFunction;
  parameters:TFunctionItemParameters;
begin
  returnticket := TViewSchedulestopsFunction.Create;
  Reg.RegisterFunctionItem(returnticket);
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
