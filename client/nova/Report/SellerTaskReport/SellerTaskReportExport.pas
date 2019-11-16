unit SellerTaskReportExport;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses SellerTaskReportPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var SellerTaskReportFunctionItem:TSellerTaskReportFunctionItem;
begin
 SellerTaskReportFunctionItem:=TSellerTaskReportFunctionItem.Create;
  Reg.RegisterFunctionItem(SellerTaskReportFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('售票报表\售票员任务表',SellerTaskReportFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
