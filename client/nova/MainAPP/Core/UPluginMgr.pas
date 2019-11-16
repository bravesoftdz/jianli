{ ------------------------------------
  功能说明：平台插件管理
  创建日期：2010/11/22
  作者：ice
  版权：nova
  ------------------------------------- }
unit UPluginMgr;

interface

uses SysUtils, Classes, Windows, Contnrs,SplashFormIntf,
  RegPluginIntf,Constant,services,SplashFormImpl,
  SystemInstance,SysFactoryEx,MainFormIntf,IniFiles,
  UFrmMain,FunctionItemIntf,Generics.Collections,ConnectCFGIntf;

Type
  TPlugInInit=procedure (Reg:IRegPlugin);
  TPlugInFinal=procedure;

  TPluginLoader = Class(TObject,IRegPlugin)  //TInterfacedObject
  private
    FPackageHandle: HMODULE;
    FPackageFile: String;
    FFunctionItemList: TList<IFunctionItem>;
    Finited:boolean; //已初始化包
    FFunctionPermissionList:TObjectList<TFunctionPermission>;
  protected
    FRefCount: Integer;
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IRegPlugin}
    procedure RegisterFunctionItem(FunctionItem:IFunctionItem);
  public
    Constructor Create(const PackageFile:String;delayload:boolean=true);
    Destructor Destroy;override;
    procedure init;
    function getFunctionPermissionBykey(key:TGUID;parameter:TFunctionItemParameters):TFunctionPermission;overload;
    function getFunctionPermissionBykey(key:String;parameter:TFunctionItemParameters):TFunctionPermission;overload;

    property FunctionItemList: TList<IFunctionItem> Read FFunctionItemList;
    property FunctionPermissionList:TObjectList<TFunctionPermission> read FFunctionPermissionList;
    property PackageFile:String Read FPackageFile;
    property inited:boolean read Finited;
  End;

  TPluginMgr = Class(TObject, IInterface, IFunctionMgr)
  private
    SplashForm: TSplashFormObj;
    Tick: Integer;
    FpluginList:TList<TPluginLoader>;
    procedure WriteErrFmt(const err: String; const Args: array of const );
    function FormatPath(const s: string): string;
    procedure GetPackageList(PackageList: TStrings;beforelogin:Boolean=true);
    function findFunctionByGUID(guid:TGUID):IFunctionItem;
    function findPluginLoaderByGUID(guid:TGUID):TPluginLoader;
    function addorsetPlugin(packagename:String):TPluginLoader;
  protected
    FRefCount: Integer;
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    Constructor Create;
    Destructor Destroy; override;
    //加载包
    procedure LoadPackage(beforelogin:Boolean);  //Intf: IInterface
    //初始化包
    procedure Init;
    procedure exec(guid:TGUID;parameters:TFunctionItemParameters);
    //供登录后，从数据库取出所有注册功能用
    procedure registerFunctionPermission(packagename,functionGUID:String;parameter:TFunctionItemParameters;enable:boolean=true;menuname:String='';describe:string='');
    procedure registerSubFunctionPermission(packagename,functionGUID:String;parameter:TFunctionItemParameters;subFunctionGUID:String;enable:boolean=true;menuname:String='';describe:string='');
    function getFunctionPermission(functionitem:IFunctionItem;parameter:TFunctionItemParameters):TFunctionPermission;overload;
    function getFunctionPermission(functionkey:String;parameter:TFunctionItemParameters):TFunctionPermission;overload;
    function getFunctionPermission(functionkey:TGUID;parameter:TFunctionItemParameters):TFunctionPermission;overload;
  end;

var PluginMgr : TPluginMgr;
implementation

uses SysSvc, LogIntf, LoginIntf, StdVcl, AxCtrls, SysFactoryMgr,
  SysFactory;

{ TPluginLoader }

constructor TPluginLoader.Create(const PackageFile: String;delayload:boolean=true);
begin
  Finited:=false;
  FPackageFile:=PackageFile;
//  FFunctionItemGUIDList:=TList<TGUID>.create;
  FFunctionPermissionList:=TObjectList<TFunctionPermission>.create;
  FFunctionItemList:=TList<IFunctionItem>.create;
  //初始化时才加载
  if not delayload then
  begin
    Try
//以前代码------begin--------
//      SysSplashForm.loading(Format('正在初始化包[%s]',
//            [ExtractFileName(PackageFile)]));
//-------end--------
      SysSplashForm.loading('系统正在初始化中......');
      self.init;
    Except
      on E: Exception do
      begin
        SysSplashForm.loading(Format('处理插件Init方法出错([%s])，错误：%s',[ExtractFileName(PackageFile), E.Message]));
      end;
    End;
//  FPackageHandle:=SysUtils.LoadPackage(PackageFile);
  end
end;

destructor TPluginLoader.Destroy;
var plugInFinal: TPlugInFinal;
begin
  @plugInFinal:=GetProcAddress(FPackageHandle,'PlugInFinal');
  plugInFinal;
  SysUtils.UnloadPackage(FPackageHandle);
//  FFunctionItemGUIDList.Free;
  FFunctionPermissionList.free;
  FFunctionItemList.Free;
  inherited;
end;

function TPluginLoader.getFunctionPermissionBykey(key: TGUID;parameter:TFunctionItemParameters): TFunctionPermission;
var functionPermission:TFunctionPermission;
begin
  result:=nil;
  for functionPermission in FunctionPermissionList do
  begin
    if (GUIDToString(functionPermission.key)=GUIDToString(key))
    and (((functionPermission.parameter=nil) and (parameter=nil))
         or ((functionPermission.parameter<>nil) and (parameter<>nil) and (parameter.Text=functionPermission.parameter.Text))
        )  then
    begin
      result:=functionPermission;
      break;
    end;
  end;
end;

function TPluginLoader.getFunctionPermissionBykey(key: String;parameter:TFunctionItemParameters): TFunctionPermission;
var _key:TGUID;
begin
  _key:=StringToGUID(key);
  result:=getFunctionPermissionBykey(_key,parameter);
end;

procedure TPluginLoader.init;
var PlugInit:TPlugInInit;
begin
  FPackageHandle:=SysUtils.LoadPackage(PackageFile);
  @PlugInit:=GetProcAddress(FPackageHandle,'PlugInit');
  if(@PlugInit<>nil) then
  begin
    PlugInit(self);
    Finited:=true;
  end;
end;

function TPluginLoader.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TPluginLoader.RegisterFunctionItem(FunctionItem:IFunctionItem);
begin
  if FunctionItem<>nil then
  begin
//    if FFunctionItemList=nil then
//      FFunctionItemList := TList<IFunctionItem>.Create();
    FFunctionItemList.add(FunctionItem);
  end;
end;

function TPluginLoader._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TPluginLoader._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
end;

{ TPluginMgr }

function TPluginMgr.addorsetPlugin(packagename: String): TPluginLoader;
var isfound:boolean;
begin
  isfound:=false;
  for result in FpluginList do
  begin
    if result.PackageFile=packagename then
    begin
      isfound:=true;
      break;
    end;
  end;
  if not isfound then
  begin
    result:=TPluginLoader.Create(Packagename);
    FpluginList.Add(result);
  end;
end;

constructor TPluginMgr.Create;
begin
  FpluginList := TList<TPluginLoader>.Create;
  SplashForm:=TSplashFormObj.Create;
  TObjFactoryEx.Create([IMainForm],frmMain);
  TObjFactoryEx.Create([IFunctionMgr],self);
  TObjFactoryEx.Create([ISplashForm],SplashForm);
end;

destructor TPluginMgr.Destroy;
begin
  FpluginList.Free;
  FactoryManager.UnRegisterFactory(ISplashForm);
  SplashForm := nil;
  inherited;
end;

procedure TPluginMgr.exec(guid: TGUID;parameters:TFunctionItemParameters);
var FunctionItem: IFunctionItem;
    FunctionPermission:TFunctionPermission;
begin
  FunctionPermission:=Self.getFunctionPermission(guid,parameters);
  if (FunctionPermission<>nil) and (not FunctionPermission.enable) then
  begin
    raise Exception.Create('对不起，你没有权限使用本功能！');
  end;
  if not SysMainForm.locationTab(guid,parameters) then
  begin
    FunctionItem:=findFunctionByGUID(guid);
    if(FunctionItem<>nil) then
    try
      FunctionItem.Enter(parameters);
    except
      on E: Exception do
        SysDialogs.ShowError(E.Message);
    end;
  end;
end;

function TPluginMgr.findFunctionByGUID(guid: TGUID): IFunctionItem;
var pluginLoader:TPluginLoader;
    FunctionItem: IFunctionItem;
begin
  result:=nil;
  pluginLoader:=findPluginLoaderByGUID(guid);
  if not pluginLoader.inited then
  begin
    pluginLoader.init;
  end;
  for FunctionItem in pluginLoader.FunctionItemList do
  begin
    if GUIDToString(FunctionItem.key)=GUIDToString(guid) then
    begin
      Result:=FunctionItem;
      Break;
    end;
  end;
end;

function TPluginMgr.findPluginLoaderByGUID(guid: TGUID): TPluginLoader;
var pluginLoader:TPluginLoader;
    functionPermission:TFunctionPermission;
begin
  result:=nil;
  for pluginLoader in FpluginList do
  begin
    for functionPermission in pluginLoader.FunctionPermissionList do
    begin
      if GUIDToString(functionPermission.key)=GUIDToString(guid) then
      begin
        Result:=pluginLoader;
        Break;
      end;
    end;
  end;
end;

function TPluginMgr.FormatPath(const s: string): string;
const
  Var_AppPath = '($APP_PATH)';
begin
  Result := StringReplace(s, Var_AppPath, ExtractFilePath(Paramstr(0)),
    [rfReplaceAll, rfIgnoreCase]);
end;

function TPluginMgr.getFunctionPermission(
  functionitem: IFunctionItem;parameter:TFunctionItemParameters): TFunctionPermission;
begin
  result:=getFunctionPermission(functionitem.key,parameter);
end;

function TPluginMgr.getFunctionPermission(
  functionkey: String;parameter:TFunctionItemParameters): TFunctionPermission;
var _key:Tguid;
begin
  _key:=StringToGUID(functionkey);
  result:=getFunctionPermission(_key,parameter);
end;

function TPluginMgr.getFunctionPermission(
  functionkey: TGUID;parameter:TFunctionItemParameters): TFunctionPermission;
var pluginLoader:TPluginLoader;
    functionPermission:TFunctionPermission;
begin
  result:=nil;
  for pluginLoader in FpluginList do
  begin
    functionPermission:=pluginLoader.getFunctionPermissionBykey(functionkey,parameter);
    if functionPermission<>nil then
    begin
      result:=functionPermission;
      break;
    end;
//    for functionPermission in pluginLoader.FunctionPermissionList do
//    begin
//      if GUIDToString(functionPermission.key)=GUIDToString(functionkey) then
//      begin
//        Result:=functionPermission;
//        Break;
//      end;
//    end;
  end;
end;

procedure TPluginMgr.GetPackageList(PackageList: TStrings;beforelogin:Boolean=True);
var
  Ini: TIniFile;
  keyList:TStrings;
  i:integer;
  pluginSectionName:String;
begin
//  PackageList.LoadFromFile('PlugIn.ini');
  if beforelogin then
    pluginSectionName:='plugin'
  else
    pluginSectionName:='pluginafterlogin';
  if FileExists(ExtractFilePath(Paramstr(0))+applicationCfgName) then
  begin
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0))+applicationCfgName);
    try
      keyList:=TStringList.Create;
      try
        ini.ReadSection(pluginSectionName,keyList);
        for I := 0 to keyList.Count - 1 do
          PackageList.Add(ini.ReadString(pluginSectionName,keyList.Strings[i],''));
      finally
        keyList.Free;
      end;
    finally
      Ini.Free;
    end;
  end
  else
  begin
    SysDialogs.ShowError('找不到系统配置文件！'+applicationCfgName);
    SysMainForm.ExitApplication;
  end;;
end;

procedure TPluginMgr.Init;
var
  CurTick, WaitTime: Integer;
  LoginIntf: ILogin;
  connectCFGIntf:IConnectCFG;
  PluginLoader:TPluginLoader;
begin
//  for PluginLoader in FpluginList do
//  begin
//    Try
//      SysSplashForm.loading(Format('正在初始化包[%s]',
//            [ExtractFileName(PluginLoader.PackageFile)]));
//
//      PluginLoader.Init;
//      {$IFDEF CONSOLE}  //编译器条件开关，后面的CONSOLE为判断是否为控制台程序，其值是{$APPTYPE}的值
//      Writeln(PluginLoader.FPackageFile);
//      {$ENDIF}  //编译器条件开关结束
//    Except
//      on E: Exception do
//      begin
//        WriteErrFmt('处理插件Init方法出错([%s])，错误：%s',
//          [ExtractFileName(PluginLoader.PackageFile), E.Message]);
//      end;
//    End;
//  end;
  // 隐藏Splash窗体
    //CurTick := GetTickCount;
    //WaitTime := CurTick - Tick;
    WaitTime:=0;
    if WaitTime < SplashFormWaitTime then
    begin
      SysSplashForm.loading('正准备连接应用服务器，请稍等...');
      sleep(SplashFormWaitTime - WaitTime);
    end;
    SysSplashForm.Hide;
//    FactoryManager.UnRegisterFactory(ISplashForm);
//    SplashForm := nil;
  // 检查连接
  if SysService.QueryInterface(IConnectCFG, connectCFGIntf) = S_OK then
  begin
    if not connectCFGIntf.connectToServer then
    begin
      SysDialogs.ShowError('无法连接应用服务器');
      SysMainForm.ExitApplication;
    end;
  end;
  // 检查登录
  if SysService.QueryInterface(ILogin, LoginIntf) = S_OK then
  begin
    LoginIntf.CheckLogin;
  end
  else
  begin
    SysDialogs.ShowError('找不到登陆模块！');
    SysMainForm.ExitApplication;
  end;
end;

procedure TPluginMgr.LoadPackage(beforelogin:Boolean);
var
  aList: TStrings;
  i: Integer;
  PackageFile: String;
begin
  // 加载其他包
  aList := TStringList.Create;
  try
    SplashForm := nil;
    GetPackageList(aList,beforelogin);
    if beforelogin then
      SysSplashForm.Show;
    for i := 0 to aList.Count - 1 do
    begin
      PackageFile := aList[i];
        SysSplashForm.loading(Format('正在加载包[%s]...',[ExtractFileName(PackageFile)]));
      // 加载包
      if FileExists(PackageFile) then
      begin
        try
          FpluginList.Add(TPluginLoader.Create(PackageFile,false));
        Except
          on E: Exception do
          begin
              WriteErrFmt('加载包[%s]出错，错误：%s', [ExtractFileName(PackageFile), E.Message]);
          end;
        end;
      end
      else
        WriteErrFmt('找不到包[%s]，无法加载！', [PackageFile]);
    end;
  finally
    aList.Free;
  end;
end;

function TPluginMgr.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TPluginMgr.registerFunctionPermission(packagename,
  functionGUID: String;parameter:TFunctionItemParameters; enable: boolean;menuname:String; describe: string);
var plugin:TPluginLoader;
    functionPermission:TFunctionPermission;
begin
  plugin:=addorsetPlugin(packagename);
  functionPermission:=plugin.getFunctionPermissionBykey(functionguid,parameter);
  if not assigned(functionPermission) then
  begin
    functionPermission:=TfunctionPermission.Create(functionguid,parameter,menuname,enable,describe);
    plugin.FunctionPermissionList.Add(functionPermission);
  end;
  functionPermission.enable:=enable;
  functionPermission.describe:=describe;
end;

procedure TPluginMgr.registerSubFunctionPermission(packagename, functionGUID:String;parameter:TFunctionItemParameters;
  subFunctionGUID: String; enable: boolean;menuname:String; describe: string);
var plugin:TPluginLoader;
    functionPermission:TFunctionPermission;
begin
  plugin:=addorsetPlugin(packagename);
  functionPermission:=plugin.getFunctionPermissionBykey(functionguid,parameter);
  if not assigned(functionPermission) then
  begin
    functionPermission:=TfunctionPermission.Create(functionguid,parameter,menuname,false);
  end;
  functionPermission.addorsetSubFunction(subFunctionGUID,enable,describe);
end;

procedure TPluginMgr.WriteErrFmt(const err: String;
  const Args: array of const );
//var
//  Log: ILog;
begin
//  SysDialogs.ShowErrorFmt(err,Args);
  SysSplashForm.loading(Format(err,Args));
//  if SysService.QueryInterface(ILog, Log) = S_OK then
//    Log.WriteErrFmt(err, Args);
end;

function TPluginMgr._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TPluginMgr._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
end;

initialization

finalization
  //释放工厂管理的实例
  FactoryManager.ReleaseInstances;
  PluginMgr.Free;
end.

