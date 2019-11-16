{------------------------------------
  功能说明：BillStorage.bpl输出单元
  创建日期：2011/02/14
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillinuseManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillinusePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var BillinuseFunctionItem:TBillinuseFunctionItem;
begin
 BillinuseFunctionItem:=TBillinuseFunctionItem.Create;
  Reg.RegisterFunctionItem(BillinuseFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('票据管理\领票信息',BillinuseFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
