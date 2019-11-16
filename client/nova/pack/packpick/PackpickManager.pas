unit PackpickManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackpickPlugin;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var PackpickItem: TPackpickItem;
//   roleListItem:TRoleFunctionItem;
begin
 PackpickItem:=TPackpickItem.Create;
  Reg.RegisterFunctionItem(PackpickItem);

end;

procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
