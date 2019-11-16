{------------------------------------
  ����˵����InitBillNo.bpl�����Ԫ
  �������ڣ�2011.1.26
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit InitBillNoExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  InitBillNoPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  initBillNo: TInitBillNoFunction;
  functionParm: TFunctionItemParameters;
begin
  initBillNo := TInitBillNoFunction.Create;
  Reg.RegisterFunctionItem(initBillNo);
{$IFDEF DEBUG}
  functionParm := TFunctionItemParameters.Create;
  functionParm.CommaText := 'Ticket';
//  SysSplashForm.loading('�����˵�........');
  (SysService as IMainForm).CreateMenu('Ʊ�ݹ���\��ʼ��Ʊ��', initBillNo.key, functionParm);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
