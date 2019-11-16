unit StewardExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses StewardPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var steward:stewardManager;
  par:TFunctionItemParameters;

begin
  steward:=stewardManager.Create;
  Reg.RegisterFunctionItem(steward);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('档案管理\乘务员档案管理',steward.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
