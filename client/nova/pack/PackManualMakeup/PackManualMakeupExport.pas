unit PackManualMakeupExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackManualMakeupPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var FrmPackManualMakeupItem: TFrmPackManualMakeupItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmPackManualMakeupItem:=TFrmPackManualMakeupItem.Create;
  Reg.RegisterFunctionItem(FrmPackManualMakeupItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�а��ս����',FrmPackManualMakeupItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
