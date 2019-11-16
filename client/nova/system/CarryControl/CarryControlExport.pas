{------------------------------------
  功能说明：CarryControl.bpl输出单元
  创建日期：2011.1.26
  作者：ice
  版权：nova
-------------------------------------}
unit CarryControlExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses CarryControlPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
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
  SysSplashForm.loading('创建菜单........');
  (SysService as IMainForm).CreateMenu('系统管理\进位规则管理', CarryControlManager.key, test_parm);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
