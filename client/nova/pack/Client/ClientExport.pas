unit ClientExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件

procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ClientPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var Client:ClientManager;
  par:TFunctionItemParameters;

begin
  Client:=ClientManager.Create;
  Reg.RegisterFunctionItem(Client);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('行包管理\客户档案管理',Client.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
