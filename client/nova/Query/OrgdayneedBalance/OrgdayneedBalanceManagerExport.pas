unit OrgdayneedBalanceManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses OrgdayneedBalanceManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var orgdayneedBalanceManagerExport: TOrgdayneedBalanceManagerExport;
begin
  orgdayneedBalanceManagerExport:=TOrgdayneedBalanceManagerExport.Create;
  Reg.RegisterFunctionItem(orgdayneedBalanceManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\����ÿ�ս���',orgdayneedBalanceManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
