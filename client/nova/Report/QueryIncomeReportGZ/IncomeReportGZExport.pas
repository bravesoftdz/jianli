unit IncomeReportGZExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;
implementation
  uses IncomeReportGZPlugin;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var GZ:GZManagers;
  par:TFunctionItemParameters;

begin
  GZ:=GZManagers.Create;
  Reg.RegisterFunctionItem(GZ);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('财务报表\单位营收统计表-赣州',
            GZ.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
