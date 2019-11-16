unit SeatstatuspictureExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
procedure PlugInFinal(); // 卸载插件

exports PlugInit, PlugInFinal;

implementation

uses SeatstatuspicturePlugin;

procedure PlugInit(Reg: IRegPlugin); // 注册插件
var
  seatstatuspictureManager: TSeatstatuspictureManager;
  i: integer;
begin
  seatstatuspictureManager := TSeatstatuspictureManager.Create;
  Reg.RegisterFunctionItem(seatstatuspictureManager);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('业务管理\默认座位状态图片', seatstatuspictureManager.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // 卸载插件
begin

end;

initialization

finalization

end.
