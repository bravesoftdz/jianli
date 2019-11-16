unit UFrmUseronline;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmUseronlineEdit, NovaComboBox, NovaHelp, NovaEdit,
  NovaHComboBox, NovaCheckedComboBox, ScktComp,IniFiles,Constant;

type
  TFrmUseronline = class(TSimpleCRUDForm)
    idusername: TLabel;
    Labusercode: TLabel;
    Labdepname: TLabel;
    jsonCDSLogOut: TjsonClientDataSet;
    Label1: TLabel;
    jsonCDSenableLog: TjsonClientDataSet;
    Labisonline: TLabel;
    nvcheckboxorg: TNovaHComboBox;
    nvhelpusercode: TNovaHelp;
    nvhelpusername: TNovaHelp;
    yes: TCheckBox;
    no: TCheckBox;
    nvcheckboxdep: TNovaHComboBox;
    ClientSocket: TClientSocket;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    localhostport:integer;
    Ini: TIniFile;
  public
    { Public declarations }
  end;

var
  FrmUseronline: TFrmUseronline;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmUseronline.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClientSocket.Close;
  inherited;
end;

procedure TFrmUseronline.FormCreate(Sender: TObject);
begin
  inherited;
  nvcheckboxorg.Active := false;
  nvcheckboxorg.Active := true;

  nvcheckboxdep.Active := false;
  nvcheckboxdep.Active := true;

end;

procedure TFrmUseronline.FormShow(Sender: TObject);
begin
  inherited;
  try
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    localhostport := strtoint(Ini.ReadString('localhostport', 'port', '8888'));
    Ini.WriteString('localhostport','port',inttostr(localhostport));

  finally
     Ini.Free;
  end;

end;

procedure TFrmUseronline.tbtnDeleteClick(Sender: TObject);
var
  nResult: longword;
  sResult: string;
  i:integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('userid').AsLargeInt=sysinfo.LoginUserInfo.UserID then
  begin
    SysDialogs.ShowMessage('不能强制自己下线！');
    exit;
  end;
  if not SysDialogs.Confirm('信息提示', '确认要强制该用户下线吗!') then
    exit;

  try
  if ClientSocket.Active then
      ClientSocket.Active := False;

  if ClientSocket.Socket.Connected then
  begin
    ClientSocket.Close;
  end;
   except
    on E: Exception do
    begin
      //SysDialogs.ShowMessage('无法访问该客户端' + #13 + E.Message);
    end;
  end;
  ClientSocket.Socket.ClientType := ctBlocking;
  ClientSocket.Host :=  jcdsResult.FieldByName('ip').AsString;
  ClientSocket.Port := 8888;

  try
    i := 1;
    ClientSocket.Open;
    while (i <= 10) do
    begin
      application.ProcessMessages;
      Sleep(5);
      Inc(i);
    end;
    if ClientSocket.Socket.Connected = false then
    begin
      SysDialogs.ShowMessage('无法访问该客户端！');
    end
    else
    begin
      ClientSocket.Socket.SendText('DOWNLINE');
      SysDialogs.ShowMessage('已向该客户端发送下线指令！');
    end;
  except
    on E: Exception do
    begin
      SysDialogs.ShowMessage('无法访问'+jcdsResult.FieldByName('ip').AsString+'该客户端的'+inttostr(localhostport)+'端口' + #13 + E.Message);
    end;
  end;

 { with jsonCDSLogOut do
    try
      close;
      Params.ParamByName('useronline.userid').Value := jcdsResult.FieldByName
        ('userid').AsLargeInt;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('该用户强制下线失败：' + E.Message);
      end;
    end;}
end;

procedure TFrmUseronline.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmUseronlineEdit do
  begin
    FrmUseronlineEdit := TFrmUseronlineEdit.Create(self);
    Caption := '修改用户在线信息';
    mark := true;
    userid := jcdsResult.FieldByName('userid').AsInteger;
    nvedtip.Text := jcdsResult.FieldByName('ip').AsString;
    logintime := jcdsResult.FieldByName('logintime').AsDateTime;
    lastlogintime := jcdsResult.FieldByName('lastlogintime').AsDateTime;
    nvedtusercode.Text := jcdsResult.FieldByName('usercode').AsString;
    nvedtusername.Text := jcdsResult.FieldByName('username').AsString;
    nvedtorgname.Text := jcdsResult.FieldByName('orgname').AsString;
    nvedtdepname.Text := jcdsResult.FieldByName('depname').AsString;
    sessionid := jcdsResult.FieldByName('sessionid').AsString;
    if jcdsResult.FieldByName('isonline').AsString = 'true' then
    begin
      FrmUseronlineEdit.radioisonline.ItemIndex := 0;
    end
    else
    begin
      FrmUseronlineEdit.radioisonline.ItemIndex := 1;
    end;

    FrmUseronlineEdit.ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

procedure TFrmUseronline.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if (trim(nvhelpusercode.Text) = '') then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_u!code'] := '';
    end
    else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_u!code'] := trim
        (nvhelpusercode.Text);
    end;
    if (trim(nvhelpusername.Text) = '') then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_u!name'] := '';
    end
    else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_u!name'] := trim
        (nvhelpusername.Text);
    end;
    if trim(nvcheckboxorg.Text) = '' then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_o!name'] := '';
    end
    else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_o!name'] := trim
        (nvcheckboxorg.Text);
    end;
    if (trim(nvcheckboxdep.Text) = '') then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_d!name'] := '';
    end
    else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_d!name'] := trim
        (nvcheckboxdep.Text);
    end;
    if ((yes.Checked) and (no.Checked = false)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_t!isonline'] := 'true';
    end else if ((yes.Checked = false) and (no.Checked)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_t!isonline'] := 'false';
    end else if ((yes.Checked) and (no.Checked)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_t!isonline']:=null;
    end else if ((yes.Checked = false) and (no.Checked = false)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_t!isonline']:=null;
    end;
    Active := true;
  end;
end;

procedure TFrmUseronline.tbtnInsertClick(Sender: TObject);
var
  nResult: longword;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认让该用户允许登录吗!') then
    exit;
  with jsonCDSenableLog do
    try
      close;
      Params.ParamByName('useronline.userid').Value := jcdsResult.FieldByName
        ('userid').AsLargeInt;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('允许该用户登录失败：' + E.Message);
      end;
    end;
end;

end.
