unit OnecardscheduleExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses OnecardschedulePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var onecardschedule:onecardscheduleMS;
  par:TFunctionItemParameters;

begin
  onecardschedule:=onecardscheduleMS.Create;
  Reg.RegisterFunctionItem(onecardschedule);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\一卡通参与班次控制',onecardschedule.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
