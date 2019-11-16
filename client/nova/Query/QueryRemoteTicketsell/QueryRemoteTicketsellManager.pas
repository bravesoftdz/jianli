unit QueryRemoteTicketsellManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryRemoteTicketsellPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryRemoteTicketsell:queryRemoteTicketsellItem;
  par:TFunctionItemParameters;

begin
  queryRemoteTicketsell:=queryRemoteTicketsellItem.Create;
  Reg.RegisterFunctionItem(queryRemoteTicketsell);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('Զ�̼�Ʊ��ѯ',queryRemoteTicketsell.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
