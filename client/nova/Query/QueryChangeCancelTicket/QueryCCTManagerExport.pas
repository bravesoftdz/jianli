unit QueryCCTManagerExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  QueryCCTManagerPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  QueryCCTManager:TQueryCCTManagerPlugin;
begin
  QueryCCTManager:=TQueryCCTManagerPlugin.Create;
  Reg.RegisterFunctionItem(QueryCCTManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ��ѯ', QueryCCTManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
