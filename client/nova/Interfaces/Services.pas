{------------------------------------
  ����˵����������
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit Services;

interface

uses SysUtils,FactoryIntf,SysInfoIntf, DialogIntf, MainFormIntf, LogIntf,SysFactoryMgr,
  EncdDecdIntf, PubFn,FunctionItemIntf,SplashFormIntf;
  //ϵͳ��Ϣ����
  function SysInfo:ISysInfo;
  //ͳһ�ĶԻ������
  function SysDialogs:IDialog;
  //ϵͳ��־����
  function SysLog:ILog;
  //ϵͳ���ܽ��ܷ���
  function SysEncdDecd:IEncdDecd;
  //�����������
  function FactoryManager:TSysFactoryManager;
  //���������
  function SysMainForm:IMainForm;
  //���ܹ������
  function SysFunctionMgr:IFunctionMgr;
  //�����ӿڷ���
  function SysService:IInterface;
  //��ӭ����ӿ�
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
