{------------------------------------
  功能说明：Billtype.bpl输出单元
  创建日期：2011/02/15
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillinventoryManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillinventoryPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var BillinventoryFunctionItem:TBillinventoryFunctionItem;
begin
 BillinventoryFunctionItem:=TBillinventoryFunctionItem.Create;
  Reg.RegisterFunctionItem(BillinventoryFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('票据管理\库存管理',BillinventoryFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
