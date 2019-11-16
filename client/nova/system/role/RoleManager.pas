{------------------------------------
  功能说明：Role.bpl输出单元
  创建日期：2010/11/11
  作者：蒋伟
  版权：nova
-------------------------------------}
unit RoleManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses RolePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var
   roleListItem:TRoleFunctionItem;
begin

    roleListItem:=TRoleFunctionItem.Create;
   Reg.RegisterFunctionItem(roleListItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('系统管理\角色管理',roleListItem.key,nil);


  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
