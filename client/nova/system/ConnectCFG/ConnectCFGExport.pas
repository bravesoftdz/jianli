{------------------------------------
  功能说明：ConnectCFG.bpl输出单元
  创建日期：2010/11/24
  作者：ice
  版权：nova
-------------------------------------}
unit ConnectCFGExport;

interface
uses SysUtils,MainFormIntf,RegPluginIntf;
procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

procedure PlugInit(Reg:IRegPlugin);//注册插件
begin
   //注册功能
   reg.RegisterFunctionItem(nil);
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.

