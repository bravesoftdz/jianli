{------------------------------------
  功能说明：Route.bpl输出单元
  创建日期：2011.1.26
  作者：ice
  版权：nova
-------------------------------------}
unit RouteExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses RoutePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
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
//  SysSplashForm.loading('创建菜单........');
  (SysService as IMainForm).CreateMenu('业务管理\线路管理', routeManager.key, test_parm);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
