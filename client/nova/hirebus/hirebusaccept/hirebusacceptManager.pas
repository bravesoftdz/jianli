unit hirebusacceptManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses hirebusacceptPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var hirebusacceptItem: ThirebusacceptItem;
//   roleListItem:TRoleFunctionItem;
begin
 hirebusacceptItem:=ThirebusacceptItem.Create;
  Reg.RegisterFunctionItem(hirebusacceptItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('��������\������Ϣ',hirebusacceptItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.


