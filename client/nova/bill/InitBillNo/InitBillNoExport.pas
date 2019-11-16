{------------------------------------
  功能说明：InitBillNo.bpl输出单元
  创建日期：2011.1.26
  作者：ice
  版权：nova
-------------------------------------}
unit InitBillNoExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  InitBillNoPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  initBillNo: TInitBillNoFunction;
  functionParm: TFunctionItemParameters;
begin
  initBillNo := TInitBillNoFunction.Create;
  Reg.RegisterFunctionItem(initBillNo);
{$IFDEF DEBUG}
  functionParm := TFunctionItemParameters.Create;
  functionParm.CommaText := 'Ticket';
//  SysSplashForm.loading('创建菜单........');
  (SysService as IMainForm).CreateMenu('票据管理\初始化票号', initBillNo.key, functionParm);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
