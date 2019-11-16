unit paramExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses paramPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
//var paramManager:TparamManager;
var parameter:TparamManager;
  par:TFunctionItemParameters;

begin
  parameter:=TparamManager.Create;
  Reg.RegisterFunctionItem(parameter);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ϵͳ����\��������',parameter.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
