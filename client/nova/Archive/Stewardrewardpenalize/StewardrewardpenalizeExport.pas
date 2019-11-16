unit StewardrewardpenalizeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses StewardrewardpenalizePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var swp:SrewardpenalizeManager;
  par:TFunctionItemParameters;

begin
  swp:=SrewardpenalizeManager.Create;
  Reg.RegisterFunctionItem(swp);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('档案管理\乘务员奖惩记录管理',swp.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
