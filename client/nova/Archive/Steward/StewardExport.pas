unit StewardExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses StewardPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var steward:stewardManager;
  par:TFunctionItemParameters;

begin
  steward:=stewardManager.Create;
  Reg.RegisterFunctionItem(steward);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('��������\����Ա��������',steward.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
