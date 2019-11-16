unit QueryPackReceiveManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackReceivePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryPackReceiveItem: TQueryPackReceiveItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackReceiveItem:=TQueryPackReceiveItem.Create;
  Reg.RegisterFunctionItem(QueryPackReceiveItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�а���ѯ\�а�����Ӫ��ͳ��',QueryPackReceiveItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
