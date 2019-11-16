{------------------------------------
  功能说明：login.bpl输出单元
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit LoginExport;

interface

uses SysUtils,MainFormIntf,RegPluginIntf,Services;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation
uses LoginPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var
 reLoginFunction:TReLoginFunction;
 loginOutFunction:TLoginOutFunction;
 lockSystemFunction:TLockSystemFunction;
begin
   //注册功能
   reLoginFunction:=TReLoginFunction.Create;
   reg.RegisterFunctionItem(reLoginFunction);
   loginOutFunction:=TLoginOutFunction.Create;
   reg.RegisterFunctionItem(loginOutFunction);
   lockSystemFunction:=TLockSystemFunction.Create;
   reg.RegisterFunctionItem(lockSystemFunction);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('系统管理\退出系统', loginOutFunction.key, nil);
  SysMainForm.CreateMenu('系统管理\重新登录', reLoginFunction.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.

