unit UpdatefileExport;


interface

uses SysUtils,MainFormIntf,RegPluginIntf,Services;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation
uses UpdatefilePlugin,UpdatefileImpl;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var
 updatefileFunction:TUpdatefileFunction;
 updatefile:TUpdatefile;
begin
  updatefile:=TUpdatefile.Create;
  updatefile.updatefile;
   //注册功能
  updatefileFunction:=TUpdatefileFunction.Create;
  reg.RegisterFunctionItem(updatefileFunction);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('系统管理\在线升级', updatefileFunction.key, nil);
{$ENDIF}

end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.

