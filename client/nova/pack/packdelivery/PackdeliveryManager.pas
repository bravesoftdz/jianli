unit PackdeliveryManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackdeliveryPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var packdeliveryItem: TPackdeliveryItem;
//   roleListItem:TRoleFunctionItem;
begin
 packdeliveryItem:=TPackdeliveryItem.Create;
  Reg.RegisterFunctionItem(packdeliveryItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а���ͬ���ͻ�\',packdeliveryItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
