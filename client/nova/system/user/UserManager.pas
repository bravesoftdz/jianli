{------------------------------------
  ����˵����user.bpl�����Ԫ
  �������ڣ�2010/11/11
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit UserManager;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses UserPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var userFunctionItem: TUserFunctionItem;
//   roleListItem:TRoleFunctionItem;
begin
 userFunctionItem:=TUserFunctionItem.Create;
  Reg.RegisterFunctionItem(userFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('ϵͳ����\�û�����',userFunctionItem.key,nil);
  //(SysService as  IMainForm).CreateMenu('ϵͳ����\��ɫ����',roleFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
