unit ViproomcheckinExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ViproomcheckinPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var viproomcheckin:viproomcheckinMS;
  par:TFunctionItemParameters;

begin
  viproomcheckin:=viproomcheckinMS.Create;
  Reg.RegisterFunctionItem(viproomcheckin);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\��Ա��������',viproomcheckin.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
