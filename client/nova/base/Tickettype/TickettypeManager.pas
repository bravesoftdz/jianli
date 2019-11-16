{------------------------------------
  功能说明：ticketoutlet.bpl输出单元
  创建日期：2011/01/22
  作者：蒋伟
  版权：nova
-------------------------------------}
unit TickettypeManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TickettypePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var tickettypeFunctionItem: TTickettypeFunctionItem;
begin
 tickettypeFunctionItem:=TTickettypeFunctionItem.Create;
  Reg.RegisterFunctionItem(tickettypeFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('业务管理\票种设置',tickettypeFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
