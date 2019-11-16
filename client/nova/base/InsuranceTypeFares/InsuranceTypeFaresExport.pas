unit InsuranceTypeFaresExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;
implementation
uses InsuranceTypeFaresPlugin;


procedure PlugInit(Reg: IRegPlugin); // ע����
var
  FrmInsuranceTypeFaresItems:TFrmInsuranceTypeFaresItems;
begin
   //ע�Ṧ��
  FrmInsuranceTypeFaresItems := TFrmInsuranceTypeFaresItems.Create;
  Reg.RegisterFunctionItem(FrmInsuranceTypeFaresItems);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('��������\��������Ʊ��', FrmInsuranceTypeFaresItems.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization
end.
initialization

finalization

end.
