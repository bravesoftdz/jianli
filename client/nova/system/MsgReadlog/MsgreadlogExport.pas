{------------------------------------
  ����˵����Msgreadlog.bpl�����Ԫ
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit MsgreadlogExport;

interface

uses SysUtils,MainFormIntf,RegPluginIntf,Services,
jsonClientDataSet,db;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation
uses MsgreadlogPlugin , UDMPublic;
procedure PlugInit(Reg:IRegPlugin);//ע����
var
 msgFunction:TMsgFunction;

  nResult: integer;
  sResult: string;
  jcdsLogout: TjsonClientDataSet;
begin
  jcdsLogout := TjsonClientDataSet.Create(nil);
  jcdsLogout.Params.CreateParam(ftString, 'msg', ptOutput);
  jcdsLogout.Params.CreateParam(ftBCD, 'flag', ptOutput);
  jcdsLogout.RemoteServer := UDMPublic.DMPublic.jcon;
  jcdsLogout.SaveAddress := 'system/isneedRead';
  //�����Ƿ�����Ҫ��ʾ��������¼
  with jcdsLogout do
  begin
      close;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
          //ע�Ṧ��
          msgFunction:=tmsgFunction.Create;
      end
      else

  end;
  Reg.RegisterFunctionItem(msgFunction);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('��־��ȡ��¼', msgFunction.key, nil);
{$ENDIF}

end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.

