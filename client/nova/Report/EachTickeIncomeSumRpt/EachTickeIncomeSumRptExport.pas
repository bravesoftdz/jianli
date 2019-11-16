unit EachTickeIncomeSumRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses EachTickeIncomeSumRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var eachTickeIncomeSumRpt:EachTickeIncomeSumRptManager;
  par:TFunctionItemParameters;

begin
  eachTickeIncomeSumRpt:=EachTickeIncomeSumRptManager.Create;
  Reg.RegisterFunctionItem(eachTickeIncomeSumRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('各站互售互退营收汇总表',eachTickeIncomeSumRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
