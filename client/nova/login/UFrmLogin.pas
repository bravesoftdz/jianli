{ ------------------------------------
  功能说明：登陆窗口
  创建日期：2010/11/11
  作者：ice
  版权：nova
  ------------------------------------- }
unit UFrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, StdCtrls, Buttons, LoginUser, ExtCtrls, DB,
  DBClient, jsonClientDataSet, UDMPublic, GIFImg, Generics.Collections,
  USimpleEditForm, jpeg, inifiles, Constant, ImgList,ShellAPI, NovaHComboBox;

type
  TLoginType = (ltlogin, ltrelogin,ltlocksystem);

  TfrmLogin = class(TSimpleEditForm)
    jsonClientDataSetLogin: TjsonClientDataSet;
    edtUserpwd: TEdit;
    edtUsername: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    chkSavePassword: TCheckBox;
    chkAutoLogin: TCheckBox;
    jcdsGetTicketLength: TjsonClientDataSet;
    tmrForeground: TTimer;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblSavePassword: TLabel;
    Label4: TLabel;
    jcdsMenuPermissionQry: TjsonClientDataSet;
    tmrAutologin: TTimer;
    Novahticketout: TNovaHComboBox;
    Label5: TLabel;
    lblName: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrForegroundTimer(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAutoLoginClick(Sender: TObject);
    procedure tmrAutologinTimer(Sender: TObject);
    procedure lblSavePasswordClick(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NovahticketoutChange(Sender: TObject);
  private
    procedure getAllBillLength;
    procedure login;
    procedure loadMenuPermission;
  public
    { Public declarations }
    Ini: TIniFile;
    LoginType: TLoginType; // 登录类型
    procedure loadlogininfo;
  end;

var
  frmLogin: TfrmLogin;

const
  LSFW_LOCK = 1;
  LSFW_UNLOCK = 2;

function LockSetForegroundWindow(uLockCode: DWORD): BOOL; stdcall;

implementation

uses SysInfoIntf, services, FunctionItemIntf, pubfn;

function LockSetForegroundWindow;
external 'user32.dll' name 'LockSetForegroundWindow';
{$R *.dfm}

procedure TfrmLogin.lblSavePasswordClick(Sender: TObject);
begin
  inherited;
  if chkSavePassword.Checked then
     chkSavePassword.Checked:=false
  else
    chkSavePassword.Checked:=true;
end;

procedure TfrmLogin.loadlogininfo;
var
  UserName, password, autologin,ticketoutletcode: String;
begin
  Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
  try
     ticketoutletcode := Ini.ReadString('ticketoutlet', 'code', '');
     Novahticketout.SetItemIndexByField('code',ticketoutletcode) ;
     lblname.caption:=Novahticketout.HelpFieldValue['name'];
    {UserName := SysEncdDecd.Decrypt(EncryptDefaultKey,
      Ini.ReadString('userinfo', 'username',
        SysEncdDecd.Encrypt(EncryptDefaultKey, '')));
    password := SysEncdDecd.Decrypt(EncryptDefaultKey,
      Ini.ReadString('userinfo', 'password',
        SysEncdDecd.Encrypt(EncryptDefaultKey, '')));
    autologin := Ini.ReadString('userinfo', 'isautologin', '');
    if UserName <> '' then
    begin
      chkSavePassword.Checked := true;
      edtUsername.Text := UserName;
      edtUserpwd.Text := password;
      if autologin = 'true' then
      begin
        chkAutoLogin.Checked := true;
      end;
    end; }
  except
    on E: Exception do
    begin
      Ini.Free;
      exit;
    end;
  end;
end;

procedure TfrmLogin.loadMenuPermission;
var
  functionitemparameter: TFunctionItemParameters;
begin
  with jcdsMenuPermissionQry do
  try
  begin
    Active := False;
    Active := true;
    first;
    while not eof do
    begin
      if fieldbyname('parameter').IsNull or
        (trim(fieldbyname('parameter').AsString) = '') then
      begin
        functionitemparameter := nil;
      end
      else
      begin
        functionitemparameter := TFunctionItemParameters.Create;
        functionitemparameter.CommaText := fieldbyname('parameter')
          .AsString;
      end;
      if fieldbyname('type').AsInteger = 0 then // 菜单权限
      begin
        if (not fieldbyname('functionkey').IsNull) and
          (trim(fieldbyname('functionkey').AsString) <> '')
          then
        begin
          if fieldbyname('menuid').IsNull then // 无菜单功能
            SysFunctionMgr.registerFunctionPermission
              (fieldbyname('packagename').AsString,
              fieldbyname('functionkey').AsString,
              functionitemparameter, true, '')
          else
            SysFunctionMgr.registerFunctionPermission
              (fieldbyname('packagename').AsString,
              fieldbyname('functionkey').AsString,
              functionitemparameter,
              fieldbyname('haspermission').AsBoolean,
              fieldbyname('name').AsString);
        end;
        if fieldbyname('haspermission').AsBoolean and (not fieldbyname('menuid').IsNull) then
        begin
//           t1:=GetTickCount;
          SysMainForm.CreateMenu(fieldbyname('menuid').AsLargeInt,
            fieldbyname('name').AsString,
            fieldbyname('functionkey').AsString,
            functionitemparameter, fieldbyname('parentid').AsLargeInt,
            fieldbyname('haspermission').AsBoolean,
            nvl(fieldbyname('hotkey').AsString, ''));
//           OutputDebugString(PwideChar('menus:'+UIntToStr(GetTickCount-t1)));
        end;
      end
      else // 可控权限
      begin
        SysFunctionMgr.registerSubFunctionPermission
          (fieldbyname('packagename').AsString,
          fieldbyname('functionkey').AsString, functionitemparameter,
          fieldbyname('subfunctionkey').AsString,
          fieldbyname('haspermission').AsBoolean);
      end;
      next;
//       t1:=GetTickCount;
//       OutputDebugString(PwideChar('permission:'+UIntToStr(t1-t0)));
//       t0:=t1;
    end;
  end;
  except
      on E: Exception do
      begin
        SysLog.WriteErr('该用户登录失败：' + E.Message);
      end;
  end;
end;

procedure TfrmLogin.bbtnSaveClick(Sender: TObject);
begin
  login;
end;

procedure TfrmLogin.chkAutoLoginClick(Sender: TObject);
begin
  inherited;
  if chkAutoLogin.Checked then
    chkSavePassword.Checked := true;
end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if (LoginType=ltlocksystem) and (self.ModalResult<>mrOk) then
  begin
    SysDialogs.Warning('系统已经被 '+sysinfo.LoginUserInfo.UserName+' 锁定！');
    CanClose:=false;
  end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
var userName,uPassword:string;
begin
  inherited;
  SetWindowLong(self.Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
//  self.Left := Screen.Monitors[0].Left+(Screen.Monitors[0].Width-self.Width) div 2;
//  self.Top := Screen.Monitors[0].Top+(Screen.Monitors[0].Height-self.Height) div 2;
  //自动登录 zhangqingfeng start
  UserName := ParamStr(1);
  uPassword := ParamStr(2);
  if (UserName<>'') and (uPassword<>'') then
  begin
    edtUsername.Text := ParamStr(1);
    edtUserpwd.Text := ParamStr(2);
    chkAutoLogin.Checked := true;
    tmrAutologin.Enabled:=true;
    tmrAutologin.Interval :=10;
  end;
//自动登录 zhangqingfeng end
end;

procedure TfrmLogin.FormDeactivate(Sender: TObject);
begin
  inherited;
  tmrForeground.Enabled := true;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
  //Novahticketout.Active:=false;
 // Novahticketout.Active:=true;
  tmrForeground.Enabled := true;
  loadlogininfo;
  //tmrAutologin.Enabled:=True;
  if LoginType=ltlocksystem then
  begin
    edtUsername.Text:=SysInfo.LoginUserInfo.UserCode;
    edtUsername.Enabled:=false;
    BitBtn2.Enabled:=false;
    self.Caption:='系统锁定';
  end;
end;

procedure TfrmLogin.getAllBillLength;
var
  billLength: TDictionary<String, Integer>;
  tcode: String;
  tLength: Integer;
begin
  with jcdsGetTicketLength do
  begin
    Active := False;
    Active := true;
    if recordcount > 0 then
    begin
      first;
      billLength := TDictionary<String, Integer>.Create();
      while (not eof) do
      begin
        tcode := fieldbyname('code').AsString;
        tLength := fieldbyname('ticketnolength').AsInteger;
        billLength.Add(tcode, tLength);
        next;
      end;
      SysInfo.curBillLength := billLength;
    end;
  end;
end;

procedure TfrmLogin.Label4Click(Sender: TObject);
begin
  inherited;
  if chkAutoLogin.Checked then
     chkAutoLogin.Checked:=false
  else
    chkAutoLogin.Checked:=true;
end;

procedure TfrmLogin.login;
var
  nResult: Integer;
  LoginUserInfo: TLoginUserInfo;
  sResult: String;
  ticketoutletcode: String;
begin
  try

    ticketoutletcode := Ini.ReadString('ticketoutlet', 'code', '');
   { if trim(Novahticketout.Text) = '' then
    begin
      SysDialogs.ShowError('请输入售票点！');
      //Ini.Free;
      Novahticketout.SetFocus;
      exit;
    end
    else
    begin
      ticketoutletcode:=trim(Novahticketout.Text) ;
    end; }
  except
    on E: Exception do
    begin
      SysDialogs.ShowError('请配置所属售票点！');
      Ini.Free;
      exit;
    end;
  end;

  with jsonClientDataSetLogin do
  begin
    if trim(edtUsername.Text) <> '' then
    begin
      try
        // t0:=GetTickCount;
        Close;
        Params.ParamByName('username').Value := edtUsername.Text;
        Params.ParamByName('userpwd').Value := edtUserpwd.Text;
        Params.ParamByName('ticketoutletcode').Value := ticketoutletcode;

        // active := true;
        Execute;
        nResult := Params.ParamByName('flag').Value;
        if (nResult <> 1) then
        begin
          Self.Visible := True;
          sResult := Params.ParamByName('msg').Value;
          SysDialogs.ShowError(sResult);
          edtUserpwd.SetFocus;
          exit;
        end
        else
        begin
        if LoginType<>ltlocksystem then
        begin
          Ini.WriteString('ticketoutlet','code',ticketoutletcode);
          LoginUserInfo := TLoginUserInfo.Create;
          LoginUserInfo.UserID := Params.ParamByName('global.userinfo.id')
            .Value;
          LoginUserInfo.UserName := Params.ParamByName('global.userinfo.name')
            .Value;
          LoginUserInfo.OrgID := Params.ParamByName('global.userinfo.orgid')
            .Value;
          LoginUserInfo.OrgName := Params.ParamByName
            ('global.organization.name').Value;
          LoginUserInfo.OrgIDs := Params.ParamByName('global.orgIDs').Value;
          LoginUserInfo.departmentID := Params.ParamByName
            ('global.department.id').Value;
          LoginUserInfo.departmentName := Params.ParamByName
            ('global.department.name').Value;
          LoginUserInfo.StationID := Params.ParamByName
            ('global.organization.station.id').Value;
          LoginUserInfo.UserCode := Params.ParamByName('global.userinfo.code')
            .Value;
          LoginUserInfo.ticketoutletsid := Params.ParamByName
            ('global.ticketoutlets.id').Value;
          LoginUserInfo.ticketoutletsname := Params.ParamByName
            ('global.ticketoutlets.name').Value;
          LoginUserInfo.stationname:=Params.ParamByName('global.stationname').Value;
          if Params.ParamByName('global.organization.organ.id').Value<>null then
          begin
             LoginUserInfo.POrgID:=Params.ParamByName('global.organization.organ.id').Value;
             LoginUserInfo.POrgName:=Params.ParamByName('global.organization.organ.name').Value;
          end;

          SysMainForm.ShowStatus(1, '当前机构：' + LoginUserInfo.OrgName);

          SysMainForm.ShowStatus(3,FormatDateTime('YYYY.MM.DD',Date)+' 星期'+getWeekNum(DayOfWeek(Now()))+' '+FormatDateTime('HH:MM:SS',Time));
          SysMainForm.ShowStatus(2, '登录售票点：' + LoginUserInfo.ticketoutletsname);
          SysMainForm.ShowStatus(4, '用户所属部门：' + LoginUserInfo.departmentName);
          SysMainForm.ShowStatus(5, '登录用户：' + LoginUserInfo.UserName);
          SysMainForm.setLblloginname(LoginUserInfo.UserName);
          LoginUserInfo.RoleID := 1;
          LoginUserInfo.IsAdmin := False;
          SysInfo.LoginUserInfo := LoginUserInfo;
         { if chkSavePassword.Checked then
          begin
            Ini.WriteString('userinfo', 'username',
              SysEncdDecd.Encrypt(EncryptDefaultKey, edtUsername.Text));
            Ini.WriteString('userinfo', 'password',
              SysEncdDecd.Encrypt(EncryptDefaultKey, edtUserpwd.Text));
            if chkAutoLogin.Checked then
              Ini.WriteString('userinfo', 'isautologin', 'true')
            else
              Ini.WriteString('userinfo', 'isautologin', 'false')
          end
          else
          begin
            Ini.WriteString('userinfo', 'username', '');
            Ini.WriteString('userinfo', 'password', '');
            Ini.WriteString('userinfo', 'isautologin', 'false')
          end; }

        end;

        end;
        if LoginType = ltlogin then
        begin
          // 获取全局票号长度
          getAllBillLength;
          // 从服务器读取菜单及权限数据，初始化主程序的菜单
          loadMenuPermission;
          SysMainForm.loadchrom;
          Syslog.WriteLog('用户登录', '登录', '用户登录');
        end;
        self.ModalResult := mrOK;
      finally
        
     end;
    end
    else
      SysDialogs.Warning('请输入用户名！');
  end;
end;

procedure TfrmLogin.NovahticketoutChange(Sender: TObject);
begin
  //inherited;
  lblname.caption:=Novahticketout.HelpFieldValue['name'];
end;

procedure TfrmLogin.tmrAutologinTimer(Sender: TObject);
begin
 inherited;
 tmrAutologin.Enabled:=false;
 if chkAutoLogin.Checked then
 begin
   Self.Visible := False;
   login;
 end;
end;

procedure TfrmLogin.tmrForegroundTimer(Sender: TObject);
var
  OldPt, NewPt: Tpoint;
begin
  inherited;
 tmrForeground.Enabled := False;
  // SetForegroundWindow(handle);
  // SetActiveWindow(handle);

  // SetForegroundWindow(Handle);
  // self.BringToFront;
  // SendMessage(self.Handle, WM_NCACTIVATE, Ord(True), 0);

  if (IsIconic(Application.Handle)) then
    Application.Restore;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  // 保存鼠标位置，模拟点击窗口，然后再还原鼠标位置
 GetCursorPos(OldPt);
  NewPt := Point(0, 0);
  Windows.ClientToScreen(Handle, NewPt);
  SetCursorPos(NewPt.X, NewPt.Y);
  mouse_event(MOUSEEVENTF_LEFTDOWN, NewPt.X, NewPt.Y, 0, 0);
  mouse_event(MOUSEEVENTF_LEFTUP, NewPt.X, NewPt.Y, 0, 0);
  SetCursorPos(OldPt.X, OldPt.Y);
end;

end.
