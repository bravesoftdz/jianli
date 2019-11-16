unit PackPaymentManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackPaymentPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var PackPaymentItem: TPackPaymentItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackPaymentItem:=TPackPaymentItem.Create;
  Reg.RegisterFunctionItem(PackPaymentItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�а��ɿ�',PackPaymentItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
