unit PackWarehousingManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackWarehousingPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var PackWarehousingItem: TPackWarehousingItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackWarehousingItem:=TPackWarehousingItem.Create;
  Reg.RegisterFunctionItem(PackWarehousingItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�������',PackWarehousingItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
