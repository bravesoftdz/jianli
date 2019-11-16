unit PackGoodsManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackGoodsPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var PackGoodsItem: TPackGoodsItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackGoodsItem:=TPackGoodsItem.Create;
  Reg.RegisterFunctionItem(PackGoodsItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\С���Ĵ�',PackGoodsItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
