unit PCticketentranceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses PCticketentrancePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var entrance:PCEntrance;
  par:TFunctionItemParameters;

begin
  entrance:=PCEntrance.Create;
  Reg.RegisterFunctionItem(entrance);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ���Կ���',entrance.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
