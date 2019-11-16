unit ClientExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����

procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses ClientPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var Client:ClientManager;
  par:TFunctionItemParameters;

begin
  Client:=ClientManager.Create;
  Reg.RegisterFunctionItem(Client);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('�а�����\�ͻ���������',Client.key,par);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
