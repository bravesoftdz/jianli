unit OutstationupmoneyManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses OutstationupmoneyPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var OutstationupmoneyItem: TOutstationupmoneyItem;
//   roleListItem:TRoleFunctionItem;
begin
 OutstationupmoneyItem:=TOutstationupmoneyItem.Create;
  Reg.RegisterFunctionItem(OutstationupmoneyItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�������\��վ�ɿ',OutstationupmoneyItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
