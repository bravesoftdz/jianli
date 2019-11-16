unit VipremainmoneyManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses VipremainmoneyManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var vipremainmoneyManagerExport:TVipremainmoneyExport;
begin
  vipremainmoneyManagerExport:=TVipremainmoneyExport.Create;
  Reg.RegisterFunctionItem(vipremainmoneyManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('×ÛºÏ²éÑ¯\VIP²¹¿¨Ã÷Ï¸²éÑ¯',vipremainmoneyManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
