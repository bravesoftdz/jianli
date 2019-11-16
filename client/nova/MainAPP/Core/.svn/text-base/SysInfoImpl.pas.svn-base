{------------------------------------
  功能说明：实现系统信息
  创建日期：2010/11/25
  作者：ice
  版权：nova
-------------------------------------}
unit SysInfoImpl;

interface

uses sysUtils,SysInfoIntf,Constant,CardManage,SysFactory,LoginUser,Generics.Collections;

Type
  TSysInfoObj=Class(TInterfacedObject,ISysInfo)
  private
    FLoginUserInfo:TLoginUserInfo;
    FcardManage:TCardManage;
    FserverURL:string;  //eg:   http://127.0.0.1:80/Station
    FserverSecretKey:string;
    FLocalHostName:string;
    FLocalHostAddress:string;
    FBillLength:TDictionary<String,Integer>;
    function getCurBillLength: TDictionary<String,Integer>;
    procedure setCurBillLength(FBillLength:TDictionary<String,Integer>);
  protected
    {ISysInfo}
    function AppPath:string;//程序目录
    function ErrPath:string;//错误日志目录
    function getServerURL:string;  //应用服务器连接URL  eg:   http://127.0.0.1:80/Station
    procedure SetServerURL(url:String);
    function getServerSecretKey:string;  //连接应用服务器密钥
    procedure SetServerSecretKey(secretKey:String);
    function getLoginUserInfo:TLoginUserInfo;
    procedure setLoginUserINfo(info:TLoginUserInfo);

    function getLocalHostAddress : string;
    procedure setLocalHostAddress(LocalHostAddress:string);
    function getLocalHostName : string;
    procedure setLocalHostName(LocalHostName:string);

    procedure setCardManage(cardManage:TCardManage);
    function getCardManage:TCardManage;
  public
    Constructor Create;
    Destructor Destroy; override;
    property serverURL:string read getServerURL write SetServerURL;
    property serverSecretKey:string read getServerSecretKey write SetServerSecretKey;
    property LoginUserInfo:TLoginUserInfo read getLoginUserInfo write setLoginUserInfo;
    property LocalHostAddress:String read getLocalHostAddress write setLocalHostAddress;
    property LocalHostName:String read getLocalHostName write setLocalHostName;
    property curBillLength:TDictionary<String,Integer> read getCurBillLength write setCurBillLength;
    property cardManage:TCardManage read getCardManage write setCardManage;
  End;

implementation

uses IniFiles;

{ TSysInfoIntfObj }

function TSysInfoObj.AppPath: string;
begin
  Result:=ExtractFilePath(Paramstr(0));
end;

constructor TSysInfoObj.Create;
begin
    inherited;
end;

destructor TSysInfoObj.Destroy;
begin
  if Assigned(FcardManage) then
     FcardManage.Destory;
  inherited;
end;

function TSysInfoObj.ErrPath: string;
begin
  Result:=AppPath+'error';
  if not DirectoryExists(Result) then
    ForceDirectories(Result);
end;

function TSysInfoObj.getServerSecretKey: string;
begin
  result:=FserverSecretKey;
end;

function TSysInfoObj.getServerURL: string;
begin
  result:=FserverURL;
end;



procedure TSysInfoObj.setCardManage(cardManage: TCardManage);
begin
   self.FcardManage:= cardManage;
end;

procedure TSysInfoObj.setCurBillLength(FBillLength:TDictionary<String,Integer>);
begin
   self.FBillLength:= FBillLength;
end;

procedure TSysInfoObj.setLocalHostAddress(LocalHostAddress: string);
begin
  self.FLocalHostAddress :=LocalHostAddress;
end;

procedure TSysInfoObj.setLocalHostName(LocalHostName: string);
begin
  self.FLocalHostName:=LocalHostName;
end;

procedure TSysInfoObj.setLoginUserINfo(info: TLoginUserInfo);
begin
  self.FLoginUserInfo:=info;
end;

function TSysInfoObj.getCardManage: TCardManage;
begin
   Result:=self.FcardManage;
end;

function TSysInfoObj.getCurBillLength: TDictionary<String,Integer>;
begin
  result:=FBillLength;
end;

function TSysInfoObj.getLocalHostAddress: string;
begin
  result:=self.FLocalHostAddress;
end;

function TSysInfoObj.getLocalHostName: string;
begin
  result:=self.FLocalHostName;
end;

function TSysInfoObj.getLoginUserInfo: TLoginUserInfo;
begin
  Result:=FLoginUserInfo;
end;

procedure TSysInfoObj.SetServerSecretKey(secretKey: String);
begin
  FserverSecretKey:=secretKey;
end;

procedure TSysInfoObj.SetServerURL(url: String);
begin
  FserverURL:=url;
end;

procedure CreateSysInfoObj(out anInstance: IInterface);
begin
  anInstance:=TSysInfoObj.Create;
end;

initialization
  TSingletonFactory.Create(ISysInfo,@CreateSysInfoObj);
finalization

end.
