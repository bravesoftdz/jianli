unit ViproomcheckinExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ViproomcheckinPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var viproomcheckin:viproomcheckinMS;
  par:TFunctionItemParameters;

begin
  viproomcheckin:=viproomcheckinMS.Create;
  Reg.RegisterFunctionItem(viproomcheckin);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('档案管理\会员进入贵宾室',viproomcheckin.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
