unit DepartinvoicesSellerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DepartinvoicesSellerPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
//var paramManager:TparamManager;
var DSManager:TDSManager;
  par:TFunctionItemParameters;

begin
  DSManager:=TDSManager.Create;
  Reg.RegisterFunctionItem(DSManager);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���񱨱�\��ƱԱ���㵥',DSManager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
