{------------------------------------
  ����˵����MenuManager.bpl�����Ԫ
  �������ڣ�2011.07.07
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit MenuManagerExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  MenuManagerPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  MenuManager:TMenuManager;
begin
  MenuManager:=TMenuManager.Create;
  Reg.RegisterFunctionItem(MenuManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('ϵͳ����\�˵�����', MenuManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
