unit PCcontrolExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses PCcontrolPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var controls:PCcontrols;
  par:TFunctionItemParameters;

begin
  controls:=PCcontrols.Create;
  Reg.RegisterFunctionItem(controls);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ���Կ��۰�ο���',controls.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
