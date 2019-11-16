unit PackPaymentManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackPaymentPlugin;

procedure PlugInit(Reg:IRegPlugin);//注册插件
var PackPaymentItem: TPackPaymentItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackPaymentItem:=TPackPaymentItem.Create;
  Reg.RegisterFunctionItem(PackPaymentItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('行包管理\行包缴款',PackPaymentItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.
