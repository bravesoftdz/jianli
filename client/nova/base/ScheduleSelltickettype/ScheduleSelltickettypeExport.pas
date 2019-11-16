unit ScheduleSelltickettypeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ScheduleSelltickettypePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var selltickettype:selltickettypeMS;
  par:TFunctionItemParameters;

begin
  selltickettype:=selltickettypeMS.Create;
  Reg.RegisterFunctionItem(selltickettype);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\班次预售票种控制',selltickettype.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
