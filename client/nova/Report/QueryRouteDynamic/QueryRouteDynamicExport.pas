unit QueryRouteDynamicExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRouteDynamicPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var querysrouteDynamic:routeDynamicManager;
  par:TFunctionItemParameters;

begin
  querysrouteDynamic:=routeDynamicManager.Create;
  Reg.RegisterFunctionItem(querysrouteDynamic);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���˰��߶�̬��',querysrouteDynamic.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
