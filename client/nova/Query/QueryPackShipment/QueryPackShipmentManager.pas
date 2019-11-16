unit QueryPackShipmentManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackShipmentPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryPackShipmentItem: TQueryPackShipmentItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackShipmentItem:=TQueryPackShipmentItem.Create;
  Reg.RegisterFunctionItem(QueryPackShipmentItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�а���ѯ\�а�����Ӫ��ͳ��',QueryPackShipmentItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
