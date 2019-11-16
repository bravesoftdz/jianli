{------------------------------------
  功能说明：Billtype.bpl输出单元
  创建日期：2011/02/15
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillAmountDestroyExport;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillAmountDestroyPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var BillAmountDestroyFunctionItem:TBillAmountDestroyFunctionItem;
begin
 BillAmountDestroyFunctionItem:=TBillAmountDestroyFunctionItem.Create;
  Reg.RegisterFunctionItem(BillAmountDestroyFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('票据管理\票据金额核销',BillAmountDestroyFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
