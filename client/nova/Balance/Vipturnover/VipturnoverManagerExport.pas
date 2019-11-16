unit VipturnoverManagerExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VipTurnoverManagerPlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var vipTurnover:VipturnoverManager;
  par:TFunctionItemParameters;

begin
  vipTurnover:=VipturnoverManager.Create;
  Reg.RegisterFunctionItem(vipTurnover);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('VIP½É¿î',vipTurnover.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
