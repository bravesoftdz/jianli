unit QueryGoodsManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryGoodsPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryGoodsItem: TQueryGoodsItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryGoodsItem:=TQueryGoodsItem.Create;
  Reg.RegisterFunctionItem(QueryGoodsItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�а���ѯ\С��Ӫ��ͳ��',QueryGoodsItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.

