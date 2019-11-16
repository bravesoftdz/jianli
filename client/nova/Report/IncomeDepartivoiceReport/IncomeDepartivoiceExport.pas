unit IncomeDepartivoiceExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses incomeDepartivoicePlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var incomeDepartivoice:incomeDepartivoiceManager;
  par:TFunctionItemParameters;

begin
  incomeDepartivoice := incomeDepartivoiceManager.Create;
  Reg.RegisterFunctionItem(incomeDepartivoice);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('营收运量统计表',incomeDepartivoice.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
