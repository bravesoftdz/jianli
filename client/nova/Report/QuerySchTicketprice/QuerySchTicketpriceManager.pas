unit QuerySchTicketpriceManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySchTicketpricePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var querySchTicketprice:querySchTicketpriceItem;
  par:TFunctionItemParameters;

begin
  querySchTicketprice:=querySchTicketpriceItem.Create;
  Reg.RegisterFunctionItem(querySchTicketprice);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('站务分公司各班线票价情况汇总表',querySchTicketprice.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
