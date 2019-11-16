unit PackpickManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackpickPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var PackpickItem: TPackpickItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackpickItem:=TPackpickItem.Create;
  Reg.RegisterFunctionItem(PackpickItem);

end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
