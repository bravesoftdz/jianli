program DispachScreen;

uses
  windows,
  messages,
  Forms,
  ActiveX,
  RunOnce in 'RunOnce.pas',
  DispachHintForm in 'DispachHintForm.pas' {DispachForm};

{$R *.res}
var
  Ret:Integer;

begin
  Application.Initialize;
  if AppHasRun(Application.Handle) then
    Application.Terminate;

  Application.Title := '站务系统副屏程序';
  Application.CreateForm(TDispachForm, DispachForm);
  ShowDispachForm;
  FrmmainShow;
  Application.Run;
end.
