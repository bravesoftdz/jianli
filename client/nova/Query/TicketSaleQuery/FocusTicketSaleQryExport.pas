unit FocusTicketSaleQryExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses FocusTicketSaleQryPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var focusSaleLocalManager:TFocusSaleLocalManager;
    focusSaleOtherManager:TFocusSaleOtherManager;
  par:TFunctionItemParameters;

begin
  focusSaleLocalManager:= TFocusSaleLocalManager.Create;
  Reg.RegisterFunctionItem(focusSaleLocalManager);
  focusSaleOtherManager := TFocusSaleOtherManager.Create;
  Reg.RegisterFunctionItem(focusSaleOtherManager);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('综合查询\集中式异站售本站情况查询',focusSaleLocalManager.key,par);
  (SysService as  IMainForm).CreateMenu('综合查询\集中式本站售异站情况查询',focusSaleOtherManager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
