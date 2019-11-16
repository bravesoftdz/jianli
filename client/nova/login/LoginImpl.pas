{ ------------------------------------
  功能说明：实现IlogIn接口
  功能说明：系统常量&系统对象
  创建日期：2010/11/21
  作者：ice
  版权：nova
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
  // sys.Dialogs.ShowError('ILogin.ChangeUser方法未实现！');
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
  // sys.Dialogs.ShowError('ILogin.LockSystem方法未实现！');
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
        Syslog.WriteLog('退出系统','退出系统','退出系统');
        //SysMainForm.ExitApplication; // 关闭主窗体
        Application.Terminate;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('该用户退出失败：' + E.Message);
        FreeAndnil(jcdsLogout);
        Application.Terminate;
      end;
    end;
  end;
end;

procedure TLogin.userLogout;
begin
 if SysDialogs.Confirm('退出系统','您确认要退出系统吗？') then
 begin
    Logout;
 end;
end;

procedure TLogin.CheckLogin;
begin
  frmLogin := TfrmLogin.Create(application, nil);
  frmLogin.LoginType:=ltlogin;
  try
    if frmLogin.ShowModal <> mrOk then // 登录不成功则退出系统
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
