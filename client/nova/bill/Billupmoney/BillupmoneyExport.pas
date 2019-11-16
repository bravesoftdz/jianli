unit BillupmoneyExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses BillupmoneyPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
// var paramManager:TparamManager;
var billupmoney: TBillupmoneyPlugin;

begin
  billupmoney := TBillupmoneyPlugin.Create;
  Reg.RegisterFunctionItem(billupmoney);

  {$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('票据管理\定额票缴款',billupmoney.key,nil);
  {$ENDIF}

end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
