{------------------------------------
  ����˵����Hotkeys.bpl�����Ԫ
  �������ڣ�2011.07.13
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit HotkeysExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  HotkeysPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  HotkeysManager:THotkeysManager;
begin
  HotkeysManager:=THotkeysManager.Create;
  Reg.RegisterFunctionItem(HotkeysManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('ϵͳ����\��ݼ�����', HotkeysManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
