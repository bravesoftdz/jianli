unit VehicleparkExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleparkPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var vehicleparkEdit:vehiclepark;
  par:TFunctionItemParameters;

begin
  vehicleparkEdit:=vehiclepark.Create;
  Reg.RegisterFunctionItem(vehicleparkEdit);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('业务管理\上车卡位设置',vehicleparkEdit.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
