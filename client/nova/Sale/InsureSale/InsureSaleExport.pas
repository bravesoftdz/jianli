{------------------------------------
  ����˵����InsureSale.bpl�����Ԫ
  �������ڣ�2011.7.4
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit InsureSaleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  InsureSalePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  InsureSale: TInsureSaleFunction;
  parameters:TFunctionItemParameters;
begin
  InsureSale := TInsureSaleFunction.Create;
  Reg.RegisterFunctionItem(InsureSale);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('��Ʊ����\���۱���', InsureSale.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
