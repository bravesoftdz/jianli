{------------------------------------
  ����˵����CarryControl.bpl�����Ԫ
  �������ڣ�2011.1.26
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit CarryControlExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses CarryControlPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  CarryControlManager: TCarryControlManager;
  test_parm: TFunctionItemParameters;
  i: integer;
begin
  CarryControlManager := TCarryControlManager.Create;
  Reg.RegisterFunctionItem(CarryControlManager);
{$IFDEF DEBUG}
  test_parm := TFunctionItemParameters.Create;
  test_parm.CommaText := '12,ab';
  SysSplashForm.loading('�����˵�........');
  (SysService as IMainForm).CreateMenu('ϵͳ����\��λ�������', CarryControlManager.key, test_parm);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
