{------------------------------------
  功能说明：IConnectCFG接口实现单元
  创建日期：2010/11/24
  作者：ice
  版权：nova
-------------------------------------}
unit ConnectCFGImpl;

interface
uses ConnectCFGIntf,Services,SysFactory,UDMPublic, UFrmConnectCFG,Controls,IniFiles,SysUtils,
      Constant;

type
   TConnectCFG=class(TInterfacedObject,IConnectCFG)
   private
      //从配置文件读取
      ip:string;
      port:Integer;
      path:string;
      secretKey:String;
     procedure readCFG();
   public
    {IConnectCFG}
    function connectToServer():Boolean;
   end;

implementation

{ TConnectCFG }

function TConnectCFG.connectToServer: Boolean;
begin
  DMPublic:=TDMPublic.Create(nil);
  readCFG();

  if not TfrmConnectCFG.checkConnect(Self.ip,self.port,self.path,self.secretKey) then
  begin
    frmConnectCFG:=TfrmConnectCFG.Create(nil);
    frmConnectCFG.EdtIP.Text:=self.ip;
    frmConnectCFG.EdtPort.Text:=inttostr(self.port);
    frmConnectCFG.EdtPath.Text:=self.path;
    frmConnectCFG.EdtKey.Text:=self.secretKey;
    Result:=SysMainForm.showFormModal(frmConnectCFG)=mrOk;
  end
  else
  begin
     Result:=true;
  end;

end;

procedure TConnectCFG.readCFG;
var
  Ini: TIniFile;
begin
  if FileExists(ExtractFilePath(Paramstr(0))+applicationCfgName) then
  begin
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0))+applicationCfgName);
    try
      try
        Self.ip:=SysEncdDecd.Decrypt(EncryptDefaultKey,Ini.ReadString('server','ip',SysEncdDecd.Encrypt(EncryptDefaultKey,'127.0.0.1')));
        self.port:=StrToInt(SysEncdDecd.Decrypt(EncryptDefaultKey,Ini.ReadString('server','port',SysEncdDecd.Encrypt(EncryptDefaultKey,'80'))));
        self.path:=SysEncdDecd.Decrypt(EncryptDefaultKey,Ini.ReadString('server','path',SysEncdDecd.Encrypt(EncryptDefaultKey,'NvBusWeb')));
        self.secretKey:=SysEncdDecd.Decrypt(EncryptDefaultKey,Ini.ReadString('server','secretKey',SysEncdDecd.Encrypt(EncryptDefaultKey,'')));

     {   if ((Self.ip='') or  (inttostr(self.port)='') or  (self.path='') or (self.secretKey='')) then
          result:=false
        else
          result:=true;  }
      except on E: Exception do
      begin
        Self.ip:=Ini.ReadString('server','ip','127.0.0.1');
        self.port:=Ini.ReadInteger('server','port',80);
        self.path:=Ini.ReadString('server','path','');
        self.secretKey:=Ini.ReadString('server','secretKey','');
      end;
      end;
    finally
      Ini.Free;
    //  result:=false;
    end;
  end
  else
  begin
    SysDialogs.ShowError('找不到系统配置文件！'+applicationCfgName);
    SysMainForm.ExitApplication;
  end;;
end;

procedure Create_ConnectObj(out anInstance: IInterface);
begin
  anInstance:=TConnectCFG.Create;
end;

initialization
  TIntfFactory.Create(IConnectCFG,@Create_ConnectObj);
finalization



end.
