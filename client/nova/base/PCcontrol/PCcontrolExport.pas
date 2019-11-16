unit PCcontrolExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses PCcontrolPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var controls:PCcontrols;
  par:TFunctionItemParameters;

begin
  controls:=PCcontrols.Create;
  Reg.RegisterFunctionItem(controls);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\售票电脑可售班次控制',controls.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
