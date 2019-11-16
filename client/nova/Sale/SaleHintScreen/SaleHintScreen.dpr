program SaleHintScreen;

uses
  windows,
  messages,
  Forms,
  ActiveX,
  UnitMyForm in 'UnitMyForm.pas' {MyForm},
  UnitWait in 'UnitWait.pas' {FormWait},
  UnitUtil in 'UnitUtil.pas',
  UnitReceiptDelayThread in 'UnitReceiptDelayThread.pas',
  Unitpause in 'Unitpause.pas' {Formpause},
  RunOnce in 'RunOnce.pas';

{$R *.res}
var
  Ret:Integer;

begin
  Application.Initialize;
  if AppHasRun(Application.Handle) then
    Application.Terminate;

  Application.Title := '站务系统副屏程序';
  Application.CreateForm(TFormWait, FormWait);
  Application.CreateForm(TMyForm, MyForm);
  Application.CreateForm(TFormpause, Formpause);
  ShowWaitForm;
  FrmmainShow;
  Application.Run;
end.
