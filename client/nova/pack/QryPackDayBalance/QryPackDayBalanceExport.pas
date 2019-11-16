unit QryPackDayBalanceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses QryPackDayBalancePlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var FrmQryPackDayBalanceItem: TFrmQryPackDayBalanceItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmQryPackDayBalanceItem:=TFrmQryPackDayBalanceItem.Create;
  Reg.RegisterFunctionItem(FrmQryPackDayBalanceItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\行包日结算表',FrmQryPackDayBalanceItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
