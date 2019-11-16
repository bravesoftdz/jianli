unit VipbooktimeManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses VipbooktimePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var VipbooktimeMg:VipbooktimeMS;
begin
  VipbooktimeMg:= VipbooktimeMS.Create;
  Reg.RegisterFunctionItem(VipbooktimeMg);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\会员订票时间设置',VipbooktimeMg.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
