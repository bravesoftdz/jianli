{------------------------------------
  功能说明：user.bpl输出单元
  创建日期：2010/11/11
  作者：蒋伟
  版权：nova
-------------------------------------}
unit UserManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses UserPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var userFunctionItem: TUserFunctionItem;
//   roleListItem:TRoleFunctionItem;
begin
 userFunctionItem:=TUserFunctionItem.Create;
  Reg.RegisterFunctionItem(userFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('系统管理\用户管理',userFunctionItem.key,nil);
  //(SysService as  IMainForm).CreateMenu('系统管理\角色增加',roleFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
