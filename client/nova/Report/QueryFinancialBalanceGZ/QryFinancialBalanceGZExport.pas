unit QryFinancialBalanceGZExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QryFinancialBalanceGZPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var GZReport:GZManager;
  par:TFunctionItemParameters;

begin
  GZReport:=GZManager.Create;
  Reg.RegisterFunctionItem(GZReport);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���񱨱�\��������֧��ƽ���-����',
            GZReport.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
