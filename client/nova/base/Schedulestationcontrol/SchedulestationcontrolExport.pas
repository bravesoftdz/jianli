unit SchedulestationcontrolExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses SchedulestationcontrolPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var schedulestationcontrol:schedulestationcontrolMS;
  par:TFunctionItemParameters;

begin
  schedulestationcontrol:=schedulestationcontrolMS.Create;
  Reg.RegisterFunctionItem(schedulestationcontrol);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\班次站点售票控制',schedulestationcontrol.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
