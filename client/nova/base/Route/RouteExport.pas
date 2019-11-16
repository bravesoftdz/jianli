{------------------------------------
  ����˵����Route.bpl�����Ԫ
  �������ڣ�2011.1.26
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit RouteExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses RoutePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  routeManager: TRouteManager;
  test_parm: TFunctionItemParameters;
  i: integer;
begin
  routeManager := TRouteManager.Create;
  Reg.RegisterFunctionItem(routeManager);
{$IFDEF DEBUG}
  test_parm := TFunctionItemParameters.Create;
  test_parm.CommaText := '12,ab';
//  SysSplashForm.loading('�����˵�........');
  (SysService as IMainForm).CreateMenu('ҵ�����\��·����', routeManager.key, test_parm);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
