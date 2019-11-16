unit QuerySpecialOrderInfoExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySpecialOrderInfoPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var QuerySpecialOrderInfo:QuerySpecialOrderInfoManager;
  par:TFunctionItemParameters;

begin
  QuerySpecialOrderInfo:=QuerySpecialOrderInfoManager.Create;
  Reg.RegisterFunctionItem(QuerySpecialOrderInfo);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('调度查询\停班班次情况查询',QuerySpecialOrderInfo.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
