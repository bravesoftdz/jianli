{------------------------------------
  功能说明：Permission.bpl输出单元
  创建日期：2011.07.07
  作者：ice
  版权：nova
-------------------------------------}
unit PermissionExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  PermissionPlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  Permission:TPermission;
begin
  Permission:=TPermission.Create;
  Reg.RegisterFunctionItem(Permission);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('系统管理\权限管理', Permission.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
