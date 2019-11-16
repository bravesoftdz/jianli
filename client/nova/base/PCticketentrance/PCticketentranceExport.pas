unit PCticketentranceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses PCticketentrancePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var entrance:PCEntrance;
  par:TFunctionItemParameters;

begin
  entrance:=PCEntrance.Create;
  Reg.RegisterFunctionItem(entrance);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('业务管理\检票电脑控制',entrance.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
