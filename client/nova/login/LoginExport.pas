{------------------------------------
  ����˵����login.bpl�����Ԫ
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit LoginExport;

interface

uses SysUtils,MainFormIntf,RegPluginIntf,Services;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation
uses LoginPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var
 reLoginFunction:TReLoginFunction;
 loginOutFunction:TLoginOutFunction;
 lockSystemFunction:TLockSystemFunction;
begin
   //ע�Ṧ��
   reLoginFunction:=TReLoginFunction.Create;
   reg.RegisterFunctionItem(reLoginFunction);
   loginOutFunction:=TLoginOutFunction.Create;
   reg.RegisterFunctionItem(loginOutFunction);
   lockSystemFunction:=TLockSystemFunction.Create;
   reg.RegisterFunctionItem(lockSystemFunction);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('ϵͳ����\�˳�ϵͳ', loginOutFunction.key, nil);
  SysMainForm.CreateMenu('ϵͳ����\���µ�¼', reLoginFunction.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.

