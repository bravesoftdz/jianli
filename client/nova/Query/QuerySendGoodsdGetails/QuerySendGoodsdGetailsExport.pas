unit QuerySendGoodsdGetailsExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QuerySendGoodsdGetailsPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var FrmQuerySendGoodsdGetailsItem: TFrmQuerySendGoodsdGetailsItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmQuerySendGoodsdGetailsItem:=TFrmQuerySendGoodsdGetailsItem.Create;
  Reg.RegisterFunctionItem(FrmQuerySendGoodsdGetailsItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�а���ѯ\������ѯ',FrmQuerySendGoodsdGetailsItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
