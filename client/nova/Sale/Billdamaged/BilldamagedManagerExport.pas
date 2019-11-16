unit BilldamagedManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses BilldamagedManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var billdamagedManagerExport:TBilldamagedManagerExport;
begin
  billdamagedManagerExport:=TBilldamagedManagerExport.Create;
  Reg.RegisterFunctionItem(billdamagedManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ÊÛÆ±¹ÜÀí\»µÆ±µÇ¼Ç',billdamagedManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
