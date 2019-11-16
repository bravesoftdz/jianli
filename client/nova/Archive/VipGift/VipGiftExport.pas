unit VipGiftExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件

procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VipGiftPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var vipgift:VipGiftManager;
  par:TFunctionItemParameters;

begin
  vipgift:=VipGiftManager.Create;
  Reg.RegisterFunctionItem(vipgift);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('档案管理\会员礼品管理',vipgift.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
