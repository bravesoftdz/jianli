{------------------------------------
  ����˵����Permission.bpl�����Ԫ
  �������ڣ�2011.07.07
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit PermissionExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  PermissionPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  Permission:TPermission;
begin
  Permission:=TPermission.Create;
  Reg.RegisterFunctionItem(Permission);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('ϵͳ����\Ȩ�޹���', Permission.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
