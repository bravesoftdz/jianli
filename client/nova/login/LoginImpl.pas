{ ------------------------------------
  ����˵����ʵ��IlogIn�ӿ�
  ����˵����ϵͳ����&ϵͳ����
  �������ڣ�2010/11/21
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit LoginImpl;

interface

uses SysUtils, Controls, LoginIntf, services, SysFactory, Forms,
  jsonClientDataSet, db;

Type
  TLogin = Class(TInterfacedObject, ILogin)
  private

  protected
      { ILogin }
    procedure CheckLogin;
    procedure ChangeUser;
    procedure LockSystem;
    procedure Logout;
  public
     procedure userLogout;

  End;

implementation

uses UFrmLogin, MainFormIntf, UDMPublic;

{ TLogin }

procedure TLogin.ChangeUser;
begin
//  frmLogin := TfrmLogin.Create(application, nil);
//  frmLogin.LoginType:=relogin;
//  try
//    frmLogin.ShowModal;
//  finally
//    frmLogin.Free;
//  end;
  // sys.Dialogs.ShowError('ILogin.ChangeUser����δʵ�֣�');
end;

procedure TLogin.LockSystem;
begin
  frmLogin := TfrmLogin.Create(application, nil);
  frmLogin.LoginType:=ltlocksystem;
  try
    frmLogin.ShowModal;
  finally
    frmLogin.Free;
  end;
  // sys.Dialogs.ShowError('ILogin.LockSystem����δʵ�֣�');
end;

procedure TLogin.Logout;
var
  nResult: integer;
  sResult: string;
  jcdsLogout: TjsonClientDataSet;
begin
  jcdsLogout := TjsonClientDataSet.Create(nil);
  jcdsLogout.Params.CreateParam(ftString, 'msg', ptOutput);
  jcdsLogout.Params.CreateParam(ftBCD, 'flag', ptOutput);
  jcdsLogout.RemoteServer := UDMPublic.DMPublic.jcon;
  jcdsLogout.SaveAddress := 'system/logout';
  with jcdsLogout do
  begin
    try
      close;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        FreeAndnil(jcdsLogout);
        Syslog.WriteLog('�˳�ϵͳ','�˳�ϵͳ','�˳�ϵͳ');
        //SysMainForm.ExitApplication; // �ر�������
        Application.Terminate;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���û��˳�ʧ�ܣ�' + E.Message);
        FreeAndnil(jcdsLogout);
        Application.Terminate;
      end;
    end;
  end;
end;

procedure TLogin.userLogout;
begin
 if SysDialogs.Confirm('�˳�ϵͳ','��ȷ��Ҫ�˳�ϵͳ��') then
 begin
    Logout;
 end;
end;

procedure TLogin.CheckLogin;
begin
  frmLogin := TfrmLogin.Create(application, nil);
  frmLogin.LoginType:=ltlogin;
  try
    if frmLogin.ShowModal <> mrOk then // ��¼���ɹ����˳�ϵͳ
    begin
      //(SysService as IMainForm).ExitApplication;
      application.Terminate;
    end;
  finally
    frmLogin.Free;
  end;
end;

procedure Create_LoginObj(out anInstance: IInterface);
begin
  anInstance := TLogin.Create;
end;

initialization

TIntfFactory.Create(ILogin, @Create_LoginObj);

finalization

end.
