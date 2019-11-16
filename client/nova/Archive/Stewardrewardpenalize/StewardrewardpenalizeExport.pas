unit StewardrewardpenalizeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses StewardrewardpenalizePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var swp:SrewardpenalizeManager;
  par:TFunctionItemParameters;

begin
  swp:=SrewardpenalizeManager.Create;
  Reg.RegisterFunctionItem(swp);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\����Ա���ͼ�¼����',swp.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
