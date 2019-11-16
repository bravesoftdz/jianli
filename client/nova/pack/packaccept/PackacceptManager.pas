unit PackacceptManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackacceptPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var packacceptItem: TpackacceptItem;
//   roleListItem:TRoleFunctionItem;
begin
 packacceptItem:=TpackacceptItem.Create;
  Reg.RegisterFunctionItem(packacceptItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�������',packacceptItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
