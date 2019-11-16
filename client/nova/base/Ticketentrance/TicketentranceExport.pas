unit TicketentranceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketentrancePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var entranceEdit:TticketentranceManager;
  par:TFunctionItemParameters;

begin
  entranceEdit:=TticketentranceManager.Create;
  Reg.RegisterFunctionItem(entranceEdit);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('业务管理\检票口设置',entranceEdit.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
