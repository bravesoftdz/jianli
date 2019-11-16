unit QueryCCTManagerExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  QueryCCTManagerPlugin;

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
procedure PlugInFinal(); // Ð¶ÔØ²å¼þ

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ×¢²á²å¼þ
var
  QueryCCTManager:TQueryCCTManagerPlugin;
begin
  QueryCCTManager:=TQueryCCTManagerPlugin.Create;
  Reg.RegisterFunctionItem(QueryCCTManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('×ÛºÏ²éÑ¯\ÊÛÆ±²éÑ¯', QueryCCTManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
