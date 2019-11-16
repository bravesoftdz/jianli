{------------------------------------
  功能说明：应用服务器连接配置窗口
  创建日期：2010/11/24
  作者：ice
  版权：nova
-------------------------------------}
unit UFrmConnectCFG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ConnectCFGIntf,Services,SysFactory,IniFiles,Constant,
  ExtCtrls, DB, DBClient, jsonClientDataSet,Winsock;

type
  TfrmConnectCFG = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    EdtIP: TEdit;
    EdtPort: TEdit;
    btn1: TBitBtn;
    btnSave: TBitBtn;
    lbl3: TLabel;
    EdtPath: TEdit;
    lbl4: TLabel;
    EdtKey: TEdit;
    tmactive: TTimer;
    jsonClientDataSet1: TjsonClientDataSet;
    procedure btn1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure tmactiveTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    //测试连接
    class function checkConnect(ip:string;port:Integer;path:string;secretKey:string):boolean;

  end;

var
  frmConnectCFG: TfrmConnectCFG;

implementation
uses SystemInstance,SysInfoIntf,UDMPublic,DialogIntf,PubFn;

{$R *.dfm}

{ TfrmConnectCFG }

procedure TfrmConnectCFG.btn1Click(Sender: TObject);
begin
   btnSave.Enabled:=checkConnect(EdtIP.Text,StrToInt(EdtPort.Text),EdtPath.Text,EdtKey.Text);
end;

procedure TfrmConnectCFG.btnSaveClick(Sender: TObject);
var Ini:TiniFile;
begin
  if FileExists(ExtractFilePath(Paramstr(0))+applicationCfgName) then
  begin
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0))+applicationCfgName);
    try
      Ini.WriteString('server','ip',SysEncdDecd.Encrypt(EncryptDefaultKey,EdtIP.Text));
      ini.WriteString('server','port',SysEncdDecd.Encrypt(EncryptDefaultKey,EdtPort.Text));
      Ini.WriteString('server','path',SysEncdDecd.Encrypt(EncryptDefaultKey,EdtPath.Text));
      Ini.WriteString('server','secretKey',SysEncdDecd.Encrypt(EncryptDefaultKey,EdtKey.Text));
    finally
      Ini.Free;
    end;
  end
  else
  begin
    SysDialogs.ShowError('找不到系统配置文件！'+applicationCfgName);
    SysMainForm.ExitApplication;
  end;;
   self.ModalResult:=mrok;
end;

class function TfrmConnectCFG.checkConnect(ip: string; port: Integer; path,
  secretKey: string): boolean;
  procedure GetHost;
  var
    wVersionRequested : WORD;
    wsaData : TWSAData;
    p : PHostEnt;
    s : array[0..128] of char;
    p2 : pAnsichar;
    OutPut:array[0..100] of char;
    i:Integer;
    OutStr:String;
  begin
    inherited;
    wVersionRequested := MAKEWORD(1, 1);
    WSAStartup(wVersionRequested, wsaData);
    GetHostName(@s, 128);
    p := GetHostByName(@s);
    p2 := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
    StrPCopy(OutPut,'Hostname: '+Format('%s', [p^.h_Name])+#10#13+
                      'IPaddress: '+Format('%s',[p2])
                      );
    WSACleanup;
    OutStr:='';
    for i:=0 to length(OutPut)-1 do
    begin
      if OutPut[i]=#10 then
        break;
      OutStr:=OutStr+OutPut[i];
    end;
    SysInfo.LocalHostAddress:=p2;
    SysInfo.LocalHostName:=copy(OutStr,Pos(':',OutStr)+1,length(OutStr)-Pos(':',OutStr));;
  end;
var
  nResult:integer;
  sResult:String;
  jsonCdsTestConn:TjsonClientDataSet;
begin
   SysInfo.serverURL:='http://'+ip+':'+inttostr(port)+'/'+path+'/';
   SysInfo.serverSecretKey:=secretKey;
   GetHost;
   DMPublic.jcon.URLHost:=SysInfo.serverURL;
   try
     jsonCdsTestConn:=TjsonClientDataSet.Create(nil);
     jsonCdsTestConn.RemoteServer:=DMPublic.jcon;
     jsonCdsTestConn.ProviderName:='testConnection';
     jsonCdsTestConn.SaveAddress :='system/testConn';
     jsonCdsTestConn.DataSourceName:='connDataSet';
     jsonCdsTestConn.Params.CreateParam(ftString,'secretKey',ptInput);
     jsonCdsTestConn.Params.CreateParam(ftString,'hostAddress',ptInput);
     jsonCdsTestConn.Params.CreateParam(ftString,'hostName',ptInput);
     jsonCdsTestConn.Params.CreateParam(ftBCD,'connmsg',ptOutput);
     jsonCdsTestConn.Params.CreateParam(ftString,'sresult',ptOutput);
     jsonCdsTestConn.Params.CreateParam(ftDateTime,'curDatetime',ptOutput);

     with jsonCdsTestConn do
     begin
        active:=false;
   //     Params.ParamByName('secretKey').Value := SysInfo.serverSecretKey;
        Params.ParamByName('secretKey').Value :='NOVAKEY';
        Params.ParamByName('hostAddress').Value :=Sysinfo.LocalHostAddress;
        Params.ParamByName('hostName').Value :=Sysinfo.LocalHostName;
        Execute;

        nResult:=Params.ParamByName('connmsg').Value ;
        sResult := Params.ParamByName('sresult').Value;

        if (nResult=1) then
        begin
          Result:=true;
          SetSystemTimeEx(Params.ParamByName('curDatetime').AsDateTime);
        end
        else
        begin
          SysDialogs.ShowInfo(sResult);
          Result:=false;
        end;
     end;
   except
      on E: Exception do
      begin
       // SysDialogs.ShowError('无法连接目标服务器器，请重新配置连接2！');
       end;
   end;
  { finally
      jsonCdsTestConn:=nil;
      jsonCdsTestConn.Free;
      SysDialogs.ShowError('无法连接目标服务器器，请重新配置连接2！');
      Result:=false;
   end;}
end;

procedure TfrmConnectCFG.FormActivate(Sender: TObject);
begin
  tmactive.Interval:=100;
  tmactive.Enabled:=true;
end;

procedure TfrmConnectCFG.FormCreate(Sender: TObject);
begin
  tmactive.Enabled:=false;
end;



procedure TfrmConnectCFG.tmactiveTimer(Sender: TObject);
begin
  tmactive.Enabled:=false;
  SetForegroundWindow(Handle);
end;

end.
