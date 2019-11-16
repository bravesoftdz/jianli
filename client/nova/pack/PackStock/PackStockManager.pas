unit PackStockManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackStockPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var packStockItem: TpackStockItem;
//   roleListItem:TRoleFunctionItem;
begin
 packStockItem:=TpackStockItem.Create;
  Reg.RegisterFunctionItem(packStockItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�а����',packStockItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
