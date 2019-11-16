unit PackfeeManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses PackfeePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var packfeeItem: TPackfeeItem;
//   roleListItem:TRoleFunctionItem;
begin
 packfeeItem:=TPackfeeItem.Create;
  Reg.RegisterFunctionItem(packfeeItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�շѱ�׼����',packfeeItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
