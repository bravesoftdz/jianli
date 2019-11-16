unit SeatreserveManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses SeatreserveManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var seatreserveManagerExport: TSeatreserveManagerExport;
begin
  seatreserveManagerExport:=TSeatreserveManagerExport.Create;
  Reg.RegisterFunctionItem(seatreserveManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('售票管理\订票留位信息',seatreserveManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
