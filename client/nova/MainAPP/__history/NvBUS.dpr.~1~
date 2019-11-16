program NvBUS;
//{$APPTYPE CONSOLE}
uses
 // ExceptionLog,
  Forms,
  UFrmMain in 'UFrmMain.pas' {frmMain},
  UFrmSplash in 'UFrmSplash.pas' {frmSplash},
  SplashFormImpl in 'SplashFormImpl.pas',
  DialogsImpl in 'Core\DialogsImpl.pas',
  UPluginMgr in 'Core\UPluginMgr.pas',
  SysSvc in 'Core\SysSvc.pas',
  UFrmException in 'UFrmException.pas' {frmException},
  EncdDecdImpl in 'Core\EncdDecdImpl.pas',
  ProgressFormImpl in 'Core\ProgressFormImpl.pas',
  SysInfoImpl in 'Core\SysInfoImpl.pas',
  Base64EncdDecd in 'Core\Base64EncdDecd.pas',
  RunOnce in 'RunOnce.pas';

{$R *.res}
begin
  Application.Initialize;
 // {$IFDEF VER210}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
 // {$ENDIF}
//  if AppHasRun(Application.Handle) then
//    Application.Terminate;
  Application.MainFormOnTaskbar := True;
  Application.Title := '盛威客运站站务管理信息系统';
  Application.HintHidePause := 1000 * 30;
  Application.CreateForm(TfrmMain, frmMain);
  PluginMgr:=TPluginMgr.Create;
  PluginMgr.LoadPackage(True);
  PluginMgr.Init;
  PluginMgr.LoadPackage(false);
  Application.Run;
end.
