unit UnitManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses UnitManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var unitManagerExport:TUnitManagerExport;
begin
  unitManagerExport:=TUnitManagerExport.Create;
  Reg.RegisterFunctionItem(unitManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('业务管理\车属单位',unitManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
