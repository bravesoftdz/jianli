{------------------------------------
  ����˵����Role.bpl�����Ԫ
  �������ڣ�2010/11/11
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit RoleManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses RolePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var
   roleListItem:TRoleFunctionItem;
begin

    roleListItem:=TRoleFunctionItem.Create;
   Reg.RegisterFunctionItem(roleListItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('ϵͳ����\��ɫ����',roleListItem.key,nil);


  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
