{------------------------------------
  功能说明：服务单无
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit Services;

interface

uses SysUtils,FactoryIntf,SysInfoIntf, DialogIntf, MainFormIntf, LogIntf,SysFactoryMgr,
  EncdDecdIntf, PubFn,FunctionItemIntf,SplashFormIntf;
  //系统信息服务
  function SysInfo:ISysInfo;
  //统一的对话框服务
  function SysDialogs:IDialog;
  //系统日志服务
  function SysLog:ILog;
  //系统加密解密服务
  function SysEncdDecd:IEncdDecd;
  //工厂管理服务
  function FactoryManager:TSysFactoryManager;
  //主窗体服务
  function SysMainForm:IMainForm;
  //功能管理服务
  function SysFunctionMgr:IFunctionMgr;
  //基础接口服务
  function SysService:IInterface;
  //欢迎窗体接口
  function SysSplashForm:ISplashForm;

implementation
uses SystemInstance;

var FFactoryManager:TSysFactoryManager;

function FactoryManager:TSysFactoryManager;
begin
  if FFactoryManager=nil then
    FFactoryManager:=TSysFactoryManager.Create;
  Result:=FFactoryManager;
end;

function Sysfactory:ISysFactory;
begin
  if SysService.QueryInterface(ISysFactory,Result)<>S_OK then
    RiaseIntfNotFoundErr(ISysFactory);
end;

function SysService:IInterface;
begin
  Result:=FSysService;
end;

function SysDialogs: IDialog;
begin
  if SysService.QueryInterface(IDialog,Result)<>S_OK then
    RiaseIntfNotFoundErr(IDialog);
end;

function SysEncdDecd: IEncdDecd;
begin
  if SysService.QueryInterface(IEncdDecd,Result)<>S_OK then
    RiaseIntfNotFoundErr(IEncdDecd);
end;

function SysLog: ILog;
begin
  if SysService.QueryInterface(ILog,Result)<>S_OK then
    RiaseIntfNotFoundErr(ILog);
end;

function SysInfo: ISysInfo;
begin
  if SysService.QueryInterface(ISysInfo,Result)<>S_OK then
    RiaseIntfNotFoundErr(ISysInfo);
end;

function SysMainForm:IMainForm;
begin
  if SysService.QueryInterface(IMainForm,Result)<>S_OK then
    RiaseIntfNotFoundErr(IMainForm);
end;

function SysFunctionMgr:IFunctionMgr;
begin
  if SysService.QueryInterface(IFunctionMgr,Result)<>S_OK then
    RiaseIntfNotFoundErr(IFunctionMgr);
end;

function SysSplashForm:ISplashForm;
begin
  if SysService.QueryInterface(ISplashForm,Result)<>S_OK then
    RiaseIntfNotFoundErr(ISplashForm);
end;

initialization
  FFactoryManager:=nil;
finalization
  FreeAndNil(FFactoryManager);

end.
