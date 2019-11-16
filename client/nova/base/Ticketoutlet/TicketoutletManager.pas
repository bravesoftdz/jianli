{------------------------------------
  功能说明：tickettype.bpl输出单元
  创建日期：2011/01/22
  作者：蒋伟
  版权：nova
-------------------------------------}
unit TicketoutletManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses TicketoutletPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var ticketoutletFunctionItem: TTicketoutletFunctionItem;
begin
 ticketoutletFunctionItem:=TTicketoutletFunctionItem.Create;
  Reg.RegisterFunctionItem(ticketoutletFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('业务管理\售票点管理',ticketoutletFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
